import 'package:flutter/material.dart';

class PhotoPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final double top;
  final double left;

  const PhotoPlaceholder(
      {Key? key,
      required this.width,
      required this.height,
      required this.top,
      required this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset(left, top),
      child: FractionallySizedBox(
          widthFactor: width,
          heightFactor: height,
          child: GestureDetector(
              onTap: () {
                print('placeholder with position $left $top');
              },
              child: Container(
                color: Colors.grey,
              ))),
    );
  }
}
