import 'package:album/UI/screens/dialog_choosing_image_from_phone.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNatural extends StatelessWidget implements SheetTemplate {
  final photos;
  final sheetIndex;

  const SheetNatural({Key? key, this.photos, required this.sheetIndex})
      : super(key: key);

  //TODO Реализовать вызов всплывающего окна с возможностью добавления изображения вместо PhotoPlaceholder
  @override
  createPlaceHolders(photos, [context, albumRedactorBloc]) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {
            albumRedactorBloc.add(GetAlbumRedactorPlaceholderParams([
              element['width'] / element['height'],
              sheetIndex,
              photos.indexOf(element)
            ])),
            // print('${photos.indexOf(element)}'),
          },
          child: PhotoPlaceholder(
            width: element['width'],
            height: element['height'],
            top: element['top'],
            left: element['left'],
            image: element['image'],
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final albumRedactorBloc = BlocProvider.of<AlbumRedactorBloc>(context);

    return (photos.isNotEmpty)
        ? AspectRatio(
            aspectRatio: 1 / 2,
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: BlocListener<AlbumRedactorBloc, AlbumRedactorState>(
                  listenWhen: (previousState, state) {
                    if (state is AlbumRedactorShowPopupSheetRedactor) {
                      if (state.proportion[0].toString()[1] != 'f') {
                        return true;
                      } else {
                        return false;
                      }
                    }
                    return false;
                  },
                  listener: (context, state) {
                    if (state is AlbumRedactorShowPopupSheetRedactor) {
                      showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DialogChoosingImage(
                                proportion: state.props[0],
                                placeholderIndex: state.props[2],
                                sheetIndex: state.props[1]);
                          }).then((exit) {
                        //TODO Сделать оптимизацию проверки условий
                        if (exit == null) {
                          albumRedactorBloc
                              .add(const GetAlbumRedactorPlaceholderParams(
                            [
                              {'f'}
                            ],
                          ));
                          print(exit);
                          return;
                        } else {
                          print(exit);
                          albumRedactorBloc
                              .add(const GetAlbumRedactorPlaceholderParams(
                            [
                              {'f'}
                            ],
                          ));

                          albumRedactorBloc.add(GetUpdatedAlbum([exit]));

                          return;
                        }
                      });
                    }
                  },
                  child: Stack(
                      children: createPlaceHolders(
                          photos, context, albumRedactorBloc)),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
