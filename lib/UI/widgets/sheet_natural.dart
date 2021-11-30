import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNatural extends StatelessWidget implements SheetTemplate {
  @override
  List photos;

  late VoidCallback callback;

  eventTrigger(BuildContext context, proportion) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorPlaceholderProportion(proportion));
    print('$proportion');
  }

  eventCloseTrigger(BuildContext context, proportion) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorPlaceholderProportion(proportion));
  }

  //    BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
  //       builder: (context, state){
  //
  //       //   if (state is AlbumRedactorShowPopupSheetRedactor){
  //       //     print('state is working');
  //       //      showDialog(context: context, builder: (context){
  //       //       return Dialog(
  //       //         shape: RoundedRectangleBorder(
  //       //             borderRadius: BorderRadius.circular(10)),
  //       //         elevation: 1,
  //       //         child: FractionallySizedBox(
  //       //           widthFactor: 1.0,
  //       //           heightFactor: 0.5,
  //       //           child: Container(
  //       //             child: Stack(
  //       //               children: [
  //       //                 Center(
  //       //                   child: Container(
  //       //                     color:
  //       //                     Colors.green.withOpacity(0.2),
  //       //                     width: 100,
  //       //                     height: 100,
  //       //                   ),
  //       //                 ),
  //       //               ],
  //       //             ),
  //       //           ),
  //       //         ),
  //       //       );
  //       //     });
  //       //   } else {
  //       //
  //       //     print('state is $state');
  //       //     showDialog(context: context, builder: (context){return Dialog(
  //       //         shape: RoundedRectangleBorder(
  //       //             borderRadius: BorderRadius.circular(10)),
  //       //         elevation: 1,
  //       //         child: FractionallySizedBox(
  //       //           widthFactor: 1.0,
  //       //           heightFactor: 0.5,
  //       //           child: Container(
  //       //             child: Stack(
  //       //               children: [
  //       //                 Center(
  //       //                   child: Container(
  //       //                     color:
  //       //                     Colors.red.withOpacity(0.2),
  //       //                     width: 100,
  //       //                     height: 100,
  //       //                   ),
  //       //                 ),
  //       //               ],
  //       //             ),
  //       //           ),
  //       //         ),
  //       //       );
  //       //     });
  //       //
  //       //   }
  //       // }
  //   );
  // }
  //
  SheetNatural({
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 1,
                                child: FractionallySizedBox(
                                    widthFactor: 1.0,
                                    heightFactor: 0.5,
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              color:
                                                  Colors.green.withOpacity(0.2),
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Center(
                                              child: AspectRatio(
                                                aspectRatio:
                                                    state.props[0] * 0.5,
                                                child: Container(
                                                  color: Colors.red
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )));
                          }).then((exit) {
                        if (exit == null) {
                          eventCloseTrigger(context, [
                            {'f'}
                          ]);
                          return;
                        }
                      });
                    }
                  },
                  child: Stack(children: createPlaceHolders(photos, context)),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
