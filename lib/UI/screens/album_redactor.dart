import 'package:album/UI/icons/my_flutter_app_icons.dart';
import 'package:album/UI/widgets/button.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/sheet_natural_redactor.dart';

class AlbumRedactor extends StatelessWidget {
  final int albumIndex;
  final int sheetIndex;

  const AlbumRedactor({
    Key? key,
    required this.albumIndex,
    required this.sheetIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List? sheets;
    late double sheetsHeight;
    late double sheetsWidth;

    final AlbumRedactorBloc _albumRedactorBloc =
        BlocProvider.of<AlbumRedactorBloc>(context);
    _albumRedactorBloc.add(GetTheAlbum(albumIndex));
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование страницы')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BlocListener<AlbumRedactorBloc, AlbumRedactorState>(
              bloc: _albumRedactorBloc,
              //TODO Нужны ли одинаковые фрагменты кода внутри build и buildWhen?

              listener: (context, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  sheets = state.sheets;
                  sheetsWidth = state.sheetsWidth;
                  sheetsHeight = state.sheetsHeight;
                  _albumRedactorBloc.add(
                    GetAlbumRedactorNaturalSheet(
                      sheet: sheets![sheetIndex],
                      sheetIndex: sheetIndex,
                      sheetHeight: sheetsHeight,
                      sheetWidth: sheetsWidth,
                    ),
                  );
                }
              },
              child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
                buildWhen: (previousState, state) {
                  if (state is AlbumRedactorShowNaturalSheet) {
                    return true;
                  }

                  return false;
                },
                builder: (context, state) {
                  if (state is AlbumRedactorShowNaturalSheet) {
                    return SheetNaturalRedactor(
                      photos: state.sheet['pages'],
                      sheetIndex: state.sheetIndex,
                      sheetPropCoef: state.sheetWidth / state.sheetHeight,
                      albumIndex: albumIndex,
                      sheetName: state.sheet['name'],
                      sheetCoverLink: state.sheet['sheetCoverLink'],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Expanded(
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 60.0, left: 0.0),
                    child: CustomButton(buttonText: 'Сохранить', onTapped: () => {},),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDEDEDE),
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      child: const Icon(
                        AlbumRedactorIcons.sticker,
                        color: Color(0xFF5F5F5F),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDEDEDE),
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                        ),
                        child: const Icon(
                          AlbumRedactorIcons.text,
                          size: 18,
                          color: Color(0xFF5F5F5F),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    )
        // )
        ;
  }
}
