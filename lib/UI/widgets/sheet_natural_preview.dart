import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNaturalPreview extends StatelessWidget implements SheetTemplate {
  final photos;
  final sheetIndex;
  final sheetPropCoef;
  final int albumIndex;

  const SheetNaturalPreview ({
    Key? key,
    this.photos,
    required this.sheetIndex,
    this.sheetPropCoef,
    required this.albumIndex,
  }) : super(key: key);

  @override
  createPlaceHolders(photos, [context, albumRedactorBloc]) {
    List<Widget> result = [];
    for (var element in photos) {
      result.add(
        GestureDetector(
          onTap: () => {
            // print('${photos.indexOf(element)}'),
          },
          child: PhotoPlaceholder(
            width: element['width'],
            height: element['height'],
            top: element['top'],
            left: element['left'],
            image: element['image'],
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final albumRedactorBloc = BlocProvider.of<AlbumRedactorBloc>(context);

    return (photos.isNotEmpty)
        ? AspectRatio(
            aspectRatio: sheetPropCoef,
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                    children:
                        createPlaceHolders(photos, context, albumRedactorBloc)),
              ),
            ),
          )
        : const CircularProgressIndicator();
  }
}
