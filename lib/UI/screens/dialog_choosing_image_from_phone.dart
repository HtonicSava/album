import 'dart:io';
import 'package:album/UI/widgets/resizable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      this.sheetPropCoef,
      this.sheetWidth,
      this.sheetHeight,
      this.placeholderWidth,
      this.placeholderHeight})
      : super(key: key);

  @override
  DialogChoosingImageState createState() => DialogChoosingImageState(
      placeholderWidth, placeholderHeight, sheetIndex, placeholderIndex);
}

class DialogChoosingImageState extends State<DialogChoosingImage> {
  var _widthIncreaseCoef;
  var _heightIncreaseCoef;
  var _image;
  var _image_width;
  var _image_height;
  late double _image_proportion;
  late XFile _xfileImage;
  var imagePicker;
  var sheetIndex;
  var placeholderIndex;
  var _borderSizeCorrected = Size.zero;
  var placeholderWidth;
  var placeholderHeight;
  late double _generalIncreaseCoef;

  late double _imageStartXCord;
  late double _imageStartYCord;

  late double _resizableImageWidth;
  late double _resizableImageHeight;

  final GlobalKey _keyBorder = GlobalKey();
  final GlobalKey _keyBorderBorder = GlobalKey();
  final GlobalKey _keyPhoto = GlobalKey();

  late double _borderStartXCord;
  late double _borderStartYCord;

  void _getWidgetInfo(_) {
    final RenderBox renderBox =
        _keyBorder.currentContext?.findRenderObject() as RenderBox;
    _keyBorder.currentContext?.size;

    final Size size = renderBox.size;
    // print(
    //     'Size: ${size.width}, ${size.height} ОООООООООООООООООООООООООООООООООООООООООООООООООООООО');

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    _borderStartXCord = offset.dx;
    _borderStartYCord = offset.dy;
    // print(
    //     'Offset: ${offset.dx}, ${offset.dy} ОООООООООООООООООООООООООООООООООООООООООООООООООООООО');
  }

  bool _checkCover({solidX, solidY, solidW, solidH, x, y, w, h}) {
    if ((x <= solidX) &&
        (x + w >= solidX + solidW) &&
        (y <= solidY) &&
        (y + h >= solidY + solidH)) {
      return true;
    } else {
      return false;
    }
  }

  _getSizesAndPosition(GlobalKey key) {
    try {
      final RenderBox renderBox =
          key.currentContext?.findRenderObject() as RenderBox;
      // final RenderObject renderBoxBorder = _keyBorder.currentContext?.findRenderObject() as RenderBox;
      final Size? sizeBorder = key.currentContext!.size;

      final boxPosition = renderBox.localToGlobal(Offset.zero);

      // print('SIZE of ${key}: ${sizeBorder}');
      // print('POSITION of ${key}: ${boxPosition}');
      return {
        'SIZE': sizeBorder,
        'POSITION': boxPosition,
      };
    } catch (error) {
      print(error);
    }
  }

  DialogChoosingImageState(this.placeholderHeight, this.placeholderWidth,
      this.sheetIndex, this.placeholderIndex);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    print('init state');
    WidgetsBinding.instance?.addPostFrameCallback(_getWidgetInfo);
  }

  @override
  Widget build(BuildContext context) {
    //Передача индекса кликнутого плейсхолдера
    // print(proportion.props[1]);

    print(
        '${placeholderWidth * widget.sheetWidth} - placeholder absolute width');
    print(placeholderWidth);
    print(
        '${placeholderHeight * widget.sheetHeight} - placeholder absolute height');
    print(placeholderHeight);

    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: Stack(
        //Стэк был обёрнут во FractionallySizedBox
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          _image != null && _image_width != null && _image_height != null
              ? ResizableWidget(
                  //TODO Сделать подгрузку существующего изображения (при наличии такового)
                  // startHeight: _image_height,
                  // startWidth: _image_width,
                  startHeight: _borderSizeCorrected.width / _image_proportion,
                  startWidth: _borderSizeCorrected.width,

                  globalKeyLink: _keyPhoto,
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
            child: Stack(children: [
              IgnorePointer(
                ignoring: true,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: AspectRatio(
                      key: _keyBorderBorder,
                      aspectRatio: ((placeholderWidth * widget.sheetWidth) /
                          (placeholderHeight * widget.sheetHeight)),
                      child: MeasureSize(
                        onChange: (size) {
                          setState(() {
                            _borderSizeCorrected = size;
                            _widthIncreaseCoef = _borderSizeCorrected.width /
                                (placeholderWidth * widget.sheetWidth);
                            _heightIncreaseCoef = _borderSizeCorrected.height /
                                (placeholderHeight * widget.sheetHeight);
                            _generalIncreaseCoef =
                                (_heightIncreaseCoef + _widthIncreaseCoef) / 2;
                          });
                        },
                        onChangeOffset: (offset) {},
                        child: Container(
                          // color: Colors.white.withOpacity(0.1),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              // color: Colors.white.withOpacity(0.15),
                              // backgroundBlendMode: BlendMode.lighten,
                              border: Border.all(
                                  width: 3,
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          IgnorePointer(
            child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcOut),
              child: Stack(children: [
                IgnorePointer(
                  ignoring: true,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: AspectRatio(
                        key: _keyBorder,
                        aspectRatio: ((placeholderWidth * widget.sheetWidth) /
                            (placeholderHeight * widget.sheetHeight)),
                        child: MeasureSize(
                          onChange: (size) {
                            setState(() {
                              _borderSizeCorrected = size;
                              _widthIncreaseCoef = _borderSizeCorrected.width /
                                  (placeholderWidth * widget.sheetWidth);
                              _heightIncreaseCoef =
                                  _borderSizeCorrected.height /
                                      (placeholderHeight * widget.sheetHeight);
                              _generalIncreaseCoef =
                                  (_heightIncreaseCoef + _widthIncreaseCoef) /
                                      2;

                              // print('${widget.sheetWidth} ----- Ширина шаблона');
                              // print('${widget.sheetHeight} ----- Высота шаблона');
                              //
                              print(
                                  '${_borderSizeCorrected.width} ----- Скорректированная ширина ограничивающей рамки');
                              print(
                                  '${_borderSizeCorrected.height} ----- Скорректированная высота ограничивающей рамки');
                              //
                              // print(
                              //     '${placeholderWidth * widget.sheetWidth} ----- Абсолютная ширина ограничивающей рамки');
                              // print(
                              //     '${placeholderHeight * widget.sheetHeight} ----- Абсолютная высота ограничивающей рамки');
                              //
                              // print(
                              //     '${_widthIncreaseCoef} ----- Коэффициент уменьшения ширины');
                              // print(
                              //     '${_heightIncreaseCoef} ----- Коэффициент уменьшения высоты');
                            });
                          },
                          onChangeOffset: (offset) {},
                          child: Container(
                            // color: Colors.white.withOpacity(0.1),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                // color: Colors.white.withOpacity(0.15),
                                // backgroundBlendMode: BlendMode.lighten,
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
                Container(
                    decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                )),
              ]),
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
                    _image_height =
                        decodedImage.height.toDouble() * _generalIncreaseCoef;
                    _image_width =
                        decodedImage.width.toDouble() * _generalIncreaseCoef;

                    _image_proportion = decodedImage.width.toDouble()/decodedImage.height.toDouble();

                    // print(
                    //     '${decodedImage.height.toDouble()} - высота загруженного изображения');
                    // print(
                    //     '${decodedImage.width.toDouble()} - ширина загруженного изображения');
                    //
                    // print(
                    //     '${_image_height} - высота загруженного изображения после корректировки');
                    // print(
                    //     '${_image_width} - ширина загруженного изображения после корректировки');
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

                  print(
                      "${_getSizesAndPosition(_keyBorder)['POSITION'].dy} - Y координата рамки");
                  print(
                      "${_getSizesAndPosition(_keyBorder)['POSITION'].dx} - X координата рамки");
                  print(
                      "${_getSizesAndPosition(_keyBorder)['SIZE'].width} - ширина рамки");
                  print(
                      "${_getSizesAndPosition(_keyBorder)['SIZE'].height} - высота рамки");

                  print(
                      "${_getSizesAndPosition(_keyPhoto)['POSITION'].dy} - Y координата фото");
                  print(
                      "${_getSizesAndPosition(_keyPhoto)['POSITION'].dx} - X координата фото");
                  print(
                      "${_getSizesAndPosition(_keyPhoto)['SIZE'].width} - ширина фото");
                  print(
                      "${_getSizesAndPosition(_keyPhoto)['SIZE'].height} - высота фото");

                  print("${_checkCover(solidX: _getSizesAndPosition(_keyBorder)['POSITION'].dx, solidY: _getSizesAndPosition(_keyBorder)['POSITION'].dy, x: _getSizesAndPosition(_keyPhoto)['POSITION'].dx, y: _getSizesAndPosition(_keyPhoto)['POSITION'].dy, solidW: _getSizesAndPosition(_keyBorder)['SIZE'].width, solidH: _getSizesAndPosition(_keyBorder)['SIZE'].height, w: _getSizesAndPosition(_keyPhoto)['SIZE'].width,h: _getSizesAndPosition(_keyPhoto)['SIZE'].height)} - состояние перекрытия");

                if (_checkCover(solidX: _getSizesAndPosition(_keyBorder)['POSITION'].dx, solidY: _getSizesAndPosition(_keyBorder)['POSITION'].dy, x: _getSizesAndPosition(_keyPhoto)['POSITION'].dx, y: _getSizesAndPosition(_keyPhoto)['POSITION'].dy, solidW: _getSizesAndPosition(_keyBorder)['SIZE'].width, solidH: _getSizesAndPosition(_keyBorder)['SIZE'].height, w: _getSizesAndPosition(_keyPhoto)['SIZE'].width,h: _getSizesAndPosition(_keyPhoto)['SIZE'].height)){
                  _imageStartXCord =
                      _getSizesAndPosition(_keyBorder)['POSITION'].dx -
                          _getSizesAndPosition(_keyPhoto)['POSITION'].dx;
                  _imageStartYCord =
                      _getSizesAndPosition(_keyBorder)['POSITION'].dy -
                          _getSizesAndPosition(_keyPhoto)['POSITION'].dy;
                  _resizableImageWidth =
                      _getSizesAndPosition(_keyPhoto)['SIZE'].width;
                  _resizableImageHeight =
                      _getSizesAndPosition(_keyPhoto)['SIZE'].height;
                  Navigator.of(context).pop({
                    'sheetIndex': sheetIndex,
                    'placeholderIndex': placeholderIndex,
                    'saved': true,
                    'saveFlag': true,
                    'image': _image,
                    'imageResizeParams': {
                      'width': _resizableImageWidth / _generalIncreaseCoef,
                      'height': _resizableImageHeight / _generalIncreaseCoef,
                    },
                    'imageStartCordsForCropping': {
                      'x': _imageStartXCord / _generalIncreaseCoef,
                      'y': _imageStartYCord / _generalIncreaseCoef,
                    },
                    'croppingSizes': {
                      'width': placeholderWidth * widget.sheetWidth,
                      'height': placeholderHeight * widget.sheetHeight,
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Фото должно помещаться в рамку",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,

                      fontSize: 16.0
                  );
                }



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
    );
  }
}

typedef void OnWidgetSizeChange(Size size);

typedef void OnWidgetOffsetChange(Offset offset);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  Offset? oldOffset;
  final OnWidgetSizeChange onChange;
  final OnWidgetOffsetChange onChangeOffset;

  MeasureSizeRenderObject(this.onChange, this.onChangeOffset);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    Offset newOffset = child!.localToGlobal(Offset.infinite);

    if (oldSize == newSize) return;
    if (oldOffset == newOffset) return;

    oldSize = newSize;
    oldOffset = newOffset;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
      onChangeOffset(newOffset);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;
  final OnWidgetOffsetChange onChangeOffset;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.onChangeOffset,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange, onChangeOffset);
  }
}
