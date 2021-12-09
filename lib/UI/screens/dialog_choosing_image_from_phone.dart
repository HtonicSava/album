import 'dart:io';

import 'package:album/UI/widgets/resizable_widget.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class DialogChoosingImage extends StatefulWidget {
  //Пропорции плейсхолдеров
  final proportion;
  final placeholderIndex;
  final sheetIndex;
  final sheetPropCoef;

  const DialogChoosingImage(
      {Key? key,
      required this.proportion,
      this.placeholderIndex,
      this.sheetIndex,
      this.sheetPropCoef})
      : super(key: key);

  @override
  DialogChoosingImageState createState() =>
      DialogChoosingImageState(proportion, sheetIndex, placeholderIndex);
}

class DialogChoosingImageState extends State<DialogChoosingImage> {
  var _image;
  var _image_width;
  var _image_height;
  late XFile _xfileImage;
  var imagePicker;
  var proportion;
  var sheetIndex;
  var placeholderIndex;
  var _borderSize =Size.zero;

  DialogChoosingImageState(
      this.proportion, this.sheetIndex, this.placeholderIndex);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    //Передача индекса кликнутого плейсхолдера
    // print(proportion.props[1]);

    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 1.0,

      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          _image != null && _image_width != null && _image_height != null
              ? ResizableWidget(
                  //TODO Сделать подгрузку существующего изображения (при наличии такового)
                  startHeight: _image_height,
                  startWidth: _image_width,
                  child: Image.file(
                    _image,
                    fit: BoxFit.fill,
                  ),
                )
              : const Center(
                  child: Text(
                    'Загрузите фото',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, decoration: TextDecoration.none),
                  ),
                ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: AspectRatio(
                  aspectRatio: proportion * widget.sheetPropCoef,
                  child: MeasureSize(
                    onChange: (size) {
                      setState(() {
                        _borderSize = size;
                        print(_borderSize);
                      });
                    },
                    child: Container(
                      // color: Colors.white.withOpacity(0.1),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          backgroundBlendMode: BlendMode.lighten,
                          border: Border.all(
                              width: 3,
                              color: Colors.black.withOpacity(0.5),
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // var source = ImageSource.gallery;
                  var _picker = ImagePicker();
                  XFile? xfImage =
                      await _picker.pickImage(source: ImageSource.gallery);
                  var image = File(xfImage!.path);
                  var decodedImage =
                      await decodeImageFromList(image.readAsBytesSync());

                  setState(() {
                    _image = image;
                    _image_height = decodedImage.height.toDouble();
                    _image_width = decodedImage.width.toDouble();
                    print(_image_height);
                    print(_image_width);
                  });
                },
                child: const Text(
                  "Загрузить",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Закрыть",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'sheetIndex': sheetIndex,
                    'placeholderIndex': placeholderIndex,
                    'saved': true,
                    'saveFlag': true,
                    'image': _image
                  });
                },
                child: const Text(
                  "Сохранить",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'sheetIndex': sheetIndex,
                    'placeholderIndex': placeholderIndex,
                    'saved': true,
                    'saveFlag': false,
                    'image': ''
                  });
                },
                child: const Text(
                  "Удалить",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
      // ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       widthFactor: 1.0,
//       heightFactor: 1.0,
//
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: AlignmentDirectional.bottomCenter,
//         children: [
//           ResizableWidget(
//             child: Center(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/img/gneg.jpeg'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           IgnorePointer(
//             ignoring: true,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               child: Center(
//                 child: AspectRatio(
//                   aspectRatio: stateBloc.props[0] * 0.5,
//                   child: Container(
//                     // color: Colors.white.withOpacity(0.1),
//                     decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         backgroundBlendMode: BlendMode.lighten,
//                         border: Border.all(
//                             width: 3,
//                             color: Colors.black.withOpacity(0.5),
//                             style: BorderStyle.solid)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   var source = ImageSource.gallery;
//                   XFile image = await i
//                 },
//                 child: const Text(
//                   "Загрузить из галереи",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   "Закрыть",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//       // ),
//     );
//   }
// }

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
