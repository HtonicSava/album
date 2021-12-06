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

  //Загрузка из Hive
  List? sheets;

  Future _initHive() async {
    var albumBox = await Hive.openBox<Album>('box_for_album');
    return sheets = albumBox.getAt(0)!.sheets;

  }

  void _changeActiveNaturalSheet(BuildContext context, sheet, index) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorNaturalSheet([sheet, index]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AlbumRedactorBloc( AlbumRedactorStateInitial()),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  height: 150,
                  child: FutureBuilder(
                    future: _initHive(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      //Нет проверки sheets - вылетает исключение
                      if (!snapshot.hasData || sheets == null) {
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
                                    context, sheets![index], index)
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 16);
                          },
                        );
                      }
                    },
                  )),
            ),
            Expanded(
              child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
                buildWhen: (previousState, state) {
                  if (state is AlbumRedactorShowNaturalSheet) {
                    return true;
                  }

                  return false;
                },
                builder: (context, state) {
                  if (state is AlbumRedactorShowNaturalSheet) {
                    print(state);
                    return SheetNatural(
                      //TODO Почему не могу использовать props[0] как в dialog_choosing_image_from_phone без обновления поля родителя?
                      photos: state.sheet[0],
                      callback: () => {},
                      sheetIndex: state.sheet[1]

                    );
                  } else {
                    //TODO Заменить на проброс пустого стейта в SheetNatural?
                    return SizedBox( );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
