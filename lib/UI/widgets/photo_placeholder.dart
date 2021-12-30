import 'dart:io';

import 'package:flutter/material.dart';

class PhotoPlaceholder extends StatelessWidget {
  // final double? sheetWidth;
  // final double? sheetHeight;
  final double width;
  final double height;
  final double top;
  final double left;
  final String image;

  const PhotoPlaceholder(
      {Key? key,
      required this.width,
      required this.height,
      required this.top,
      required this.left,
      required this.image,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {



    double _left;
    double _top;

    if(left < 0.5){
      _left = left - width / 2;
    } else if(left > 0.5){
      _left = left + width / 2;
    } else {
      _left = left;
    }

    if(top < 0.5){
      _top = top - height / 2;
    } else if(top > 0.5){
      _top = top + height / 2;
    } else {
      _top = top;
    }
    // (((left*sheetWidth/sheetWidth)  - (width*sheetWidth/2)/sheetWidth)/sheetWidth)
    return Container(
      alignment: FractionalOffset(_left, _top),
      child: FractionallySizedBox(
          widthFactor: width,
          heightFactor: height,
          child: image == ''
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    image: DecorationImage(
                        image:  AssetImage('assets/img/camera.png'),),
                  ),
                )
              : Container(
                  // color: Colors.lightGreen,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:  FileImage(File(image)), fit: BoxFit.fill),
                  ),
                )),
    );
  }
}
