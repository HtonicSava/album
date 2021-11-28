import 'package:album/bloc/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor_event.dart';
import 'package:album/bloc/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sheet_preview.dart';
import 'widgets/sheet_natural.dart';

class ChoosingTemplate extends StatelessWidget {
  const ChoosingTemplate({Key? key}) : super(key: key);

  static const List sheets = [
    [
      {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.6, 'height': 0.2, 'top': 0.4, 'left': 0.5},
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
      {'width': 0.9, 'height': 0.2, 'top': 0.4, 'left': 0.1},
      {'width': 0.3, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.9, 'height': 0.2, 'top': 0.0, 'left': 1.0},
    ],
    [
      {'width': 1.0, 'height': 0.3, 'top': 0.0, 'left': 0.0},
      {'width': 1.0, 'height': 0.3, 'top': 0.5, 'left': 0.0},
      {'width': 1.0, 'height': 0.3, 'top': 1.0, 'left': 0.0},
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumRedactorBloc>(
      create: (context) => AlbumRedactorBloc(),
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
                  return SheetPreview(
                    photos: sheets[index],
                    callback: () => {
                      print('index is $index'),
                      context.read<AlbumRedactorBloc>().mapEventToState(
                          AlbumRedactorShowSheet(sheets[index]))
                    },
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
              builder: (context, state) {
                return SheetNatural(
                  photos: context.read<AlbumRedactorBloc>().state.props,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
