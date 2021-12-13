import 'dart:io';
import 'package:image/image.dart' as imgLib;

import 'package:album/UI/widgets/resizable_widget.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class DialogChoosingImage extends StatefulWidget {
  //Пропорции плейсхолдеров
  final placeholderWidth;
  final placeholderHeight;
  final placeholderIndex;
  final sheetIndex;
  final sheetPropCoef;
  final sheetWidth;
  final sheetHeight;




  const DialogChoosingImage(
      {Key? key,
      this.placeholderIndex,
      this.sheetIndex,
      this.sheetPropCoef, this.sheetWidth, this.sheetHeight, this.placeholderWidth, this.placeholderHeight})
      : super(key: key);

  @override
  DialogChoosingImageState createState() =>
      DialogChoosingImageState(placeholderWidth, placeholderHeight, sheetIndex, placeholderIndex);
}

class DialogChoosingImageState extends State<DialogChoosingImage> {
  var _widthIncreaseCoef;
  var _heightIncreaseCoef;
  var _image;
  var _image_width;
  var _image_height;
  late XFile _xfileImage;
  var imagePicker;
  var sheetIndex;
  var placeholderIndex;
  var _borderSize =Size.zero;
  var placeholderWidth;
  var placeholderHeight;
  final GlobalKey _keyBorder = GlobalKey();
  final GlobalKey _keyPhoto = GlobalKey();

  _getSizesAndPosition(){
    final RenderObject? renderBoxBorder = _keyBorder.currentContext!.findRenderObject();
    // final sizeBorder = renderBoxBorder!.localToGlobal();
    // print('SIZE of border box: ${sizeBorder}');
  }

  DialogChoosingImageState(
      this.placeholderHeight, this.placeholderWidth, this.sheetIndex, this.placeholderIndex);

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

    print('${placeholderWidth * widget.sheetWidth} - placeholder absolute width' );
    print(placeholderWidth);
    print('${placeholderHeight * widget.sheetHeight} - placeholder absolute height');
    print(placeholderHeight);

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
                  aspectRatio: ((placeholderWidth * widget.sheetWidth)/(placeholderHeight * widget.sheetHeight)),
                  child: MeasureSize(
                    onChange: (size) {
                      setState(() {
                        _borderSize = size;
                        _widthIncreaseCoef = _borderSize.width / (placeholderWidth * widget.sheetWidth);
                        _heightIncreaseCoef =  _borderSize.height / (placeholderHeight * widget.sheetHeight);


                        print('${widget.sheetWidth} ----- Ширина шаблона');
                        print('${widget.sheetHeight} ----- Высота шаблона');

                        print('${_borderSize.width} ----- Скорректированная ширина ограничивающей рамки');
                        print('${_borderSize.height} ----- Скорректированная высота ограничивающей рамки');

                        print('${placeholderWidth * widget.sheetWidth} ----- Абсолютная ширина ограничивающей рамки');
                        print('${placeholderHeight * widget.sheetHeight} ----- Абсолютная высота ограничивающей рамки');

                        print('${_widthIncreaseCoef} ----- Коэффициент уменьшения ширины');
                        print('${_heightIncreaseCoef} ----- Коэффициент уменьшения высоты');
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
                    _image_height = decodedImage.height.toDouble() * (_heightIncreaseCoef + _widthIncreaseCoef) / 2;
                    _image_width = decodedImage.width.toDouble() * (_heightIncreaseCoef + _widthIncreaseCoef) / 2;

                    print('${decodedImage.height.toDouble()} - высота загруженного изображения');
                    print('${decodedImage.width.toDouble()} - ширина загруженного изображения');


                    print('${_image_height} - высота загруженного изображения после корректировки');
                    print('${_image_width} - ширина загруженного изображения после корректировки');
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
