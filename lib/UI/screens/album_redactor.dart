import 'package:album/UI/widgets/sheet_natural_preview.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sheet_preview.dart';
import '../widgets/sheet_natural_redactor.dart';

class AlbumRedactor extends StatelessWidget {
  final int albumIndex;
  final int sheetIndex;

  AlbumRedactor({
    Key? key,
    required this.albumIndex, required this.sheetIndex,
  }) : super(key: key);

  //TODO инициализировать типы, применить касты к присвоениям

  var pageName;
  var sheets;
  var sheetsHeight;
  var sheetsWidth;

  void _changeActiveNaturalSheet(
      BuildContext context, sheet, index, proportionCoef) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorNaturalSheet([sheet, index, proportionCoef]));
  }

  @override
  Widget build(BuildContext context) {
    final AlbumRedactorBloc _albumRedactorBloc =
        BlocProvider.of<AlbumRedactorBloc>(context);
    _albumRedactorBloc.add(InitEvent(albumIndex));
    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              bloc: _albumRedactorBloc,
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  pageName = state.albumName;
                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  pageName = state.albumName;
                  return Text(pageName);
                } else {
                  return Text('Альбом');
                }

                ;
              })),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: BlocListener<AlbumRedactorBloc, AlbumRedactorState>(
                bloc: _albumRedactorBloc,
                //TODO Нужны ли одинаковые фрагменты кода внутри build и buildWhen?


                listener: (context, state) {
                  if (state is AlbumRedactorUpdateAlbum) {
                    sheets = state.props[0];
                    sheetsWidth = state.props[1];
                    sheetsHeight = state.props[2];
                    pageName = state.albumName;
                    _albumRedactorBloc.add(GetAlbumRedactorNaturalSheet([sheets[sheetIndex], sheetIndex, sheetsWidth / sheetsHeight]));

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
                        photos: state.props[0],
                        //значения индекса sheet в props[1]
                        sheetIndex: state.props[1],
                        //значения коэффициента пропорции sheet в props[2]
                        sheetPropCoef: state.props[2], albumIndex: albumIndex,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20.0),
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
                      onPressed: () {

                      },
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
