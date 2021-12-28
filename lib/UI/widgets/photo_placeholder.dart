import 'dart:io';

import 'package:flutter/material.dart';

class PhotoPlaceholder extends StatelessWidget {
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
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: FractionalOffset(left, top),
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
