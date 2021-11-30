import 'package:flutter/material.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetPreview extends StatelessWidget implements SheetTemplate {
  @override
  List photos;
  final VoidCallback callback;

  SheetPreview({Key? key, required this.photos, required this.callback})
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
        aspectRatio: 1 / 2,
        child: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(children: createPlaceHolders(photos)),
          ),
        ),
      ),
    );
  }
}
