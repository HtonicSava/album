import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sheet_preview.dart';
import '../widgets/sheet_natural.dart';

class AlbumRedactor extends StatelessWidget {
  final int albumIndex;

  AlbumRedactor({
    Key? key,
    required this.albumIndex,
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
                  return  Text('Альбом');
                }

                ;
              })),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              bloc: _albumRedactorBloc,
              //TODO Нужны ли одинаковые фрагменты кода внутри build и buildWhen?
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  sheets = state.props[0];
                  sheetsWidth = state.props[1];
                  sheetsHeight = state.props[2];
                  pageName = state.albumName;

                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  sheets = state.props[0];
                  sheetsWidth = state.props[1];
                  sheetsHeight = state.props[2];
                  pageName = state.albumName;
                }
                return SizedBox(
                    height: 150,
                    child: sheets == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: sheets!.length,
                            itemBuilder: (context, index) {
                              return SheetPreview(
                                photos: sheets![index],
                                callback: () => {
                                  _changeActiveNaturalSheet(
                                      context,
                                      sheets![index],
                                      index,
                                      sheetsWidth / sheetsHeight)
                                },
                                width: sheetsWidth,
                                height: sheetsHeight,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 16);
                            },
                          ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorShowNaturalSheet) {
                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is AlbumRedactorShowNaturalSheet) {
                  return SheetNatural(
                    //значения sheet в props[0]
                    photos: state.props[0],
                    //значения индекса sheet в props[1]
                    sheetIndex: state.props[1],
                    //значения коэффициента пропорции sheet в props[2]
                    sheetPropCoef: state.props[2],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    )
        // )
        ;
  }
}
