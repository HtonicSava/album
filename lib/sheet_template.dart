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
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    children: [
                      PhotoPlaceholder(
                          width: photos[0]['width'],
                          height: photos[0]['height'],
                          top: photos[0]['top'],
                          left: photos[0]['left']),
                      PhotoPlaceholder(
                          width: photos[1]['width'],
                          height: photos[1]['height'],
                          top: photos[1]['top'],
                          left: photos[1]['left']),
                      PhotoPlaceholder(
                          width: photos[2]['width'],
                          height: photos[2]['height'],
                          top: photos[2]['top'],
                          left: photos[2]['left']),
                    ],
                  ),
                ),
              ),
            ),
          )
        : AspectRatio(
            aspectRatio: 1 / 2,
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16),
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
