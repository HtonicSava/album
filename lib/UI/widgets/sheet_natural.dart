import 'package:album/UI/widgets/dialog_choosing_image_from_phone.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNatural extends StatelessWidget implements SheetTemplate {
  @override
   final List photos;

   final VoidCallback callback;

  eventTrigger(BuildContext context, proportion) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorPlaceholderProportion(proportion));
    print('$proportion');
  }

  eventCloseTrigger(BuildContext context, proportion) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorPlaceholderProportion(proportion));
  }

  const SheetNatural({
    Key? key,
    required this.photos,
    required this.callback,
  }) : super(key: key);

  //TODO Реализовать вызов всплывающего окна с возможностью добавления изображения вместо PhotoPlaceholder
  @override
  createPlaceHolders(photos, [context]) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {
            callback(),
            eventTrigger(context, [
              element['width'] / element['height'],
              photos.indexOf(element)
            ]),
            print('${photos.indexOf(element)}'),
          },
          child: PhotoPlaceholder(
            width: element['width'],
            height: element['height'],
            top: element['top'],
            left: element['left'],
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                      print(state.props);
                      showGeneralDialog(context: context,
                          pageBuilder:(context, animation, secondaryAnimation){
                            return DialogChoosingImage(state: state);
                          } ).then((exit){

                          if (exit == null) {
                            eventCloseTrigger(context, [
                              {'f'}
                            ]);
                            return;
                          }
                      });


                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return DialogChoosingImage(state: state);
                      //     }).then((exit) {
                      //   if (exit == null) {
                      //     eventCloseTrigger(context, [
                      //       {'f'}
                      //     ]);
                      //     return;
                      //   }
                      // });
                    }
                  },
                  child: Stack(children: createPlaceHolders(photos, context)),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  @override
  set photos(List _photos) {
    // TODO: implement photos
  }
}
