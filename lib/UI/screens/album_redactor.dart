import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../widgets/sheet_preview.dart';
import '../widgets/sheet_natural.dart';

class AlbumRedactor extends StatelessWidget {
  AlbumRedactor({Key? key}) : super(key: key);

  //TODO Вынести логику взаимодействия с БД в блок
  //Загрузка из Hive
  List? sheets;
  late double sheetsHeight;
  late double sheetsWidth;

  Future _initHive() async {
    var albumBox = await Hive.openBox<Album>('box_for_album');
    // sheets = albumBox.getAt(0)!.sheets;
    // sheetsWidth = albumBox.getAt(0)!.sheetsWidth;
    // sheetsHeight = albumBox.getAt(0)!.sheetsHeight;

    return [
      sheets = albumBox.getAt(0)!.sheets,
      sheetsWidth = albumBox.getAt(0)!.sheetsWidth,
      sheetsHeight = albumBox.getAt(0)!.sheetsHeight
    ];

    // sheetsWidth = albumBox.getAt(0)!.sheetsWidth;
    // sheetsHeight = albumBox.getAt(0)!.sheetsHeight;
  }

  void _changeActiveNaturalSheet(
      BuildContext context, sheet, index, proportionCoef) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorNaturalSheet([sheet, index, proportionCoef]));
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
              child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
                buildWhen: (previousState, state) {
                  if (state is AlbumRedactorUpdateAlbum) {
                    return true;
                  }

                  return false;
                },
                builder: (context, state) {
                  return SizedBox(
                      height: 150,
                      child: FutureBuilder(
                        future: _initHive(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          //Нет проверки sheets - вылетает исключение
                          if (!snapshot.hasData || sheets == null) {
                            // || sheetsHeight || sheetsWidth
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.separated(
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
                            );
                          }
                        },
                      ));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child:  BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
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
        ));
  }
}
