
import 'package:flutter/material.dart';

class AlbumPreview extends StatelessWidget{

  final String albumName;
  final int albumPagesNumber;

  const AlbumPreview({ required this.albumName, required this.albumPagesNumber});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      // width: 231,
      height: 380,
      child: Column(
        children: [
           Align(
            alignment:
            Alignment.centerLeft,
            child: Text(
              albumName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 8.0),
            child: Align(
              alignment:
              Alignment.centerLeft,
              child: Text(
                '${albumPagesNumber} стр.',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(
                        0xFFA5A5A5)),
              ),
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration:
                const BoxDecoration(
                  color:
                  Color(0xFFE4E4E4),
                  borderRadius:
                  BorderRadius.all(
                      Radius
                          .circular(
                          16)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}