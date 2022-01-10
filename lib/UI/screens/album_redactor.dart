import 'package:album/UI/icons/my_flutter_app_icons.dart';
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
                      //значения sheet в props[0]
                      photos: (state.props[0] as Map)['pages'],
                      //значения индекса sheet в props[1]
                      sheetIndex: state.props[1],
                      //значения коэффициента пропорции sheet в props[2]
                      sheetPropCoef: state.props[2], albumIndex: albumIndex, sheetName: (state.props[0] as Map)['name'], sheetCoverLink: (state.props[0] as Map)['sheetCoverLink'],
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    // width: 292,
                    height: 65,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFFBDBBBE),
                            Color(0xFF9D9EA3),
                          ]),
                          // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Сохранить',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
