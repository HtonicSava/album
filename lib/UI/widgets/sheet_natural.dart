import 'package:flutter/material.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNatural extends StatelessWidget implements SheetTemplate {
  @override
  List photos;

  // VoidCallback callback;

  SheetNatural({
    Key? key,
    required this.photos,
  }) : super(key: key);
  //TODO Реализовать вызов всплывающего окна с возможностью добавления изображения вместо PhotoPlaceholder
  @override
  createPlaceHolders(photos) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {},
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
                child: Stack(children: createPlaceHolders(photos)),
              ),
            ),
          )
        : const SizedBox();
  }
}
