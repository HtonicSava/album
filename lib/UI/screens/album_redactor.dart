import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sheet_preview.dart';
import '../widgets/sheet_natural.dart';

class AlbumRedactor extends StatelessWidget {
  const AlbumRedactor({Key? key}) : super(key: key);

  //TODO Заменить на подгрузку из репозитория
  static const List sheets = [
    [
      {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      // {'width': 0.6, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.5, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.5, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.7, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      // {'width': 0.9, 'height': 0.2, 'top': 0.4, 'left': 0.1},
      {'width': 0.3, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.9, 'height': 0.2, 'top': 0.0, 'left': 1.0},
    ],
    [
      {'width': 1.0, 'height': 0.3, 'top': 0.0, 'left': 0.0},
      // {'width': 1.0, 'height': 0.3, 'top': 0.5, 'left': 0.0},
      // {'width': 1.0, 'height': 0.3, 'top': 1.0, 'left': 0.0},
    ]
  ];

  void _changeActiveNaturalSheet(BuildContext context, sheet) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorNaturalSheet(sheet));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AlbumRedactorBloc(const AlbumRedactorStateInitial()),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sheets.length,
                  itemBuilder: (context, index) {
                    return BlocListener<AlbumRedactorBloc, AlbumRedactorState>(
                      listener: (context, state) {},
                      child: SheetPreview(
                        photos: sheets[index],
                        callback: () =>
                            {_changeActiveNaturalSheet(context, sheets[index])},
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
                buildWhen: (previousState, state) {
                  if (state is AlbumRedactorShowNaturalSheet ||
                      state is AlbumRedactorStateInitial) {
                    return true;
                  }

                  return false;
                },
                builder: (context, state) {
                  if (state is AlbumRedactorShowNaturalSheet ||
                      state is AlbumRedactorStateInitial) {
                    return SheetNatural(
                      photos: state.props,
                      callback: () => {
                        // print('${state.props[0]}'),
                        // _invokePopupSheetRedactor(context)
                      },
                    );
                  } else {
                    print('$state');
                    return Container(
                      width: 5,
                      height: 5,
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
