import 'package:flutter/material.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';
import 'choosing_template_provider.dart';

class SheetNatural extends StatelessWidget implements SheetTemplate {
  @override
  List photos;
  VoidCallback callback;

  var provider;

  SheetNatural(
      {Key? key, required this.photos, required this.callback, this.provider})
      : super();

  _child(item) {
    ChoosingTemplateProvider choosingTemplateProvider = provider;
    choosingTemplateProvider
        .openPhotoPlaceholder(item['width'] / item['height']);
    print('from inside $item');
  }

  @override
  createPlaceHolders(photos) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {_child(element), callback()},
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
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(children: createPlaceHolders(photos)),
        ),
      ),
    );
  }
}
