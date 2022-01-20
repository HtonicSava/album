import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SingleAlbumPageRedact extends StatelessWidget {
  final int albumId;
  const SingleAlbumPageRedact({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
            'Redact album $albumId'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Редактирование Album $albumId'
            ),

          ],
        ),
      ),
    );
  }
}
