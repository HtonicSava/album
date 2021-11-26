import 'package:flutter/material.dart';
import 'photo_placeholder.dart';

class SheetTemplate extends StatelessWidget {
  final List photos;
  final bool isPreview;
  final VoidCallback callback;

  const SheetTemplate(
      {Key? key,
      required this.photos,
      this.isPreview = false,
      required this.callback})
      : super(key: key);

  createPlaceHolders(photos) {
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
    ;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return isPreview
        ? GestureDetector(
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
          )
        : AspectRatio(
            aspectRatio: 1 / 2,
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: callback,
                      child: PhotoPlaceholder(
                          width: photos[0]['width'],
                          height: photos[0]['height'],
                          top: photos[0]['top'],
                          left: photos[0]['left']),
                    ),
                    GestureDetector(
                      onTap: callback,
                      child: PhotoPlaceholder(
                          width: photos[1]['width'],
                          height: photos[1]['height'],
                          top: photos[1]['top'],
                          left: photos[1]['left']),
                    ),
                    GestureDetector(
                      onTap: callback,
                      child: PhotoPlaceholder(
                          width: photos[2]['width'],
                          height: photos[2]['height'],
                          top: photos[2]['top'],
                          left: photos[2]['left']),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
