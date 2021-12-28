import 'package:flutter/material.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetPreview extends StatelessWidget implements SheetTemplate {
  final String sheetCoverLink;
  @override
  final List photos;
  final VoidCallback callback;
  final double width;
  final double height;

  const SheetPreview(
      {Key? key,
      required this.photos,
      required this.callback,
      required this.width,
      required this.height, required this.sheetCoverLink})
      : super(key: key);

  @override
  createPlaceHolders(photos, [context]) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        PhotoPlaceholder(
          width: element['width'],
          height: element['height'],
          top: element['top'],
          left: element['left'],
          image: element['image'],
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AspectRatio(
        aspectRatio: width / height,
        child: Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(sheetCoverLink),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(children: createPlaceHolders(photos)),
          ),
        ),
      ),
    );
  }
}
