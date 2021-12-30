import 'dart:io';

import 'package:album/UI/screens/dialog_choosing_image_from_phone.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';
import 'package:image/image.dart' as imageLib;

class SheetNaturalRedactor extends StatelessWidget implements SheetTemplate {

  final String sheetCoverLink;
  final String sheetName;
  final photos;
  final sheetIndex;
  final sheetPropCoef;
  final int albumIndex;
  // final double sheetWidth;
  // final double sheetHeight;

  const SheetNaturalRedactor({
    Key? key,
    this.photos,
    required this.sheetIndex,
    this.sheetPropCoef,
    required this.albumIndex, required this.sheetName, required this.sheetCoverLink,
  }) : super(key: key);

  @override
  createPlaceHolders(photos, [context, albumRedactorBloc]) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {
            albumRedactorBloc.add(GetAlbumRedactorPlaceholderParams([
              element['height'],
              element['width'],
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
        ? Align(
          child: AspectRatio(
              aspectRatio: sheetPropCoef,
              child: Column(
                children: [
                   Padding(
                     padding:
                     const EdgeInsets.only(left: 8.0,),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           sheetName,
                           style: const TextStyle(fontSize: 14, color: Color(0xFF686868)),
                         ),
                          IconButton(icon: Icon(Icons.more_horiz, color: Colors.black.withOpacity(0.4),), onPressed: () {  },)
                       ],
                     ),
                   ),
                  Expanded(
                    child: Container(
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(sheetCoverLink),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: BlocListener<AlbumRedactorBloc, AlbumRedactorState>(
                          listenWhen: (previousState, state) {
                            if (state is AlbumRedactorShowPopupSheetRedactor) {
                              if (state.proportion[0] != 0) {
                                return true;
                              } else {
                                return false;
                              }
                            }
                            return false;
                          },
                          listener: (context, state) {
                            if (state is AlbumRedactorShowPopupSheetRedactor) {
                              // print('\/n');
                              // print(state.props);
                              // print(state.props.runtimeType);
                              // print('\/n');

                              showGeneralDialog(
                                barrierColor: const Color(0x00000000),
                                  context: context,
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return DialogChoosingImage(
                                      sheetPropCoef: sheetPropCoef,
                                      placeholderHeight: state.props[1],
                                      placeholderWidth: state.props[0],
                                      placeholderIndex: state.props[3],
                                      sheetIndex: state.props[2],
                                      sheetWidth: state.props[4],
                                      sheetHeight: state.props[5],
                                    );
                                  }).then((exit) async {
                                //TODO Сделать оптимизацию проверки условий
                                if (exit == null) {
                                  //Нажата кнопка "закрыть"
                                  albumRedactorBloc
                                      .add(const GetAlbumRedactorPlaceholderParams(
                                    [0],
                                  ));
                                  return;
                                } else {
                                  print(exit);
                                  // Обработка приходящего из диалога ответа. При сохранении вылетает эксепшен, который не позволяет передать в блок несуществующий файл
                                  try {
                                    if ((exit as Map)['saveFlag']) {
                                      //TODO перенести логику сохранения изображения в блок
                                      final directory =
                                          await getExternalStorageDirectory();
                                      final myImagePath =
                                          '${directory!.path}/SavedAlbumImages';
                                      print(myImagePath);
                                      //TODO оптимизировать с помощью проверки существования директории
                                      //TODO передать информацию об изменениях изображения и сохранить, учитывая их
                                      await Directory(myImagePath).create();

                                      // await (exit)['image'].copy(
                                      //     '$myImagePath/albumImage${(exit)['sheetIndex']}${(exit)['placeholderIndex']}.png');
                                      // print(savedImage);

                                      print(
                                          '${(exit)['imageStartCordsForCropping']} @@@@@@@@@@');
                                      print(
                                          '${(exit)['croppingSizes']} @@@@@@@@@@@@@@');

                                      imageLib.Image? image = imageLib
                                          .decodePng((exit)['image'].readAsBytesSync());

                                      imageLib.Image? resizedImage =
                                          imageLib.copyResize(image!,
                                              width: (exit)['imageResizeParams']
                                                      ['width']
                                                  .round(),
                                              height: (exit)['imageResizeParams']
                                                      ['height']
                                                  .round());

                                      imageLib.Image croppedImage = imageLib.copyCrop(
                                          resizedImage,
                                          (exit)['imageStartCordsForCropping']['x']
                                              .round(),
                                          (exit)['imageStartCordsForCropping']['y']
                                              .round(),
                                          (exit)['croppingSizes']['width'].round(),
                                          (exit)['croppingSizes']['height'].round());

                                      File('$myImagePath/albumImage$albumIndex${(exit)['sheetIndex']}${(exit)['placeholderIndex']}.png')
                                          .writeAsBytesSync(
                                              imageLib.encodePng(croppedImage));

                                      // imageLib.Image? image = imageLib.decodePng(File('$myImagePath/albumImage${(exit)['sheetIndex']}${(exit)['placeholderIndex']}.png').readAsBytesSync());
                                      //
                                      // imageLib.Image croppedImage = imageLib.copyCrop(image!, 0, 0, 300, 300);
                                      //
                                      // File('$myImagePath/albumImage${(exit)['sheetIndex']}${(exit)['placeholderIndex']}.png').writeAsBytesSync(imageLib.encodePng(croppedImage));

                                      (exit)['image'] =
                                          '$myImagePath/albumImage$albumIndex${(exit)['sheetIndex']}${(exit)['placeholderIndex']}.png';
                                    }
                                    albumRedactorBloc.add(GetUpdatedAlbum([exit]));
                                  } catch (error) {
                                    print(error);
                                  } finally {
                                    albumRedactorBloc.add(
                                        const GetAlbumRedactorPlaceholderParams([0]));
                                  }
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
                  ),
                ],
              ),
            ),
        )
        : const SizedBox();
  }
}
