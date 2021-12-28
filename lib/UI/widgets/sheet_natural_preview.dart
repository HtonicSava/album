import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_placeholder.dart';
import 'sheet_template.dart';

class SheetNaturalPreview extends StatelessWidget implements SheetTemplate {

  final String sheetCoverLink;
  final String sheetName;
  final photos;
  final sheetIndex;
  final sheetPropCoef;
  final int albumIndex;

  const SheetNaturalPreview({
    Key? key,
    this.photos,
    required this.sheetIndex,
    this.sheetPropCoef,
    required this.albumIndex, required this.sheetName, required this.sheetCoverLink,
  }) : super(key: key);

  @override
  createPlaceHolders(photos, [context, albumRedactorBloc]) {
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
    final albumRedactorBloc = BlocProvider.of<AlbumRedactorBloc>(context);
    // Align(child: Text('alo'), alignment: Alignment.centerLeft,),

    return (photos.isNotEmpty)
        ? Column(
            children: [
              Expanded(
                child: Align(
                  child: AspectRatio(
                    aspectRatio: sheetPropCoef,
                    child: Column(
                      children: [
                         Align(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            child: Text(
                              sheetName,
                              style: const TextStyle(fontSize: 14, color: Color(0xFF686868)),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Expanded(
                          child: Container(
                            decoration:  BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(sheetCoverLink),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                                children: createPlaceHolders(
                                    photos, context, albumRedactorBloc)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : const CircularProgressIndicator();
  }
}
