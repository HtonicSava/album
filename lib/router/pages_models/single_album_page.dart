import 'package:album/router/app_router.gr.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';

class SingleAlbumPage extends StatelessWidget {
  final int albumId;
  const SingleAlbumPage({Key? key, @PathParam() required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(
            'Album $albumId'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Album $albumId'
            ),
            ElevatedButton(onPressed:
            () => {
              context.router.push(SingleAlbumRouteRedact(albumId: albumId))
            }
                , child:
              const Text('Редактировать')
            )
          ],
        ),
      ),
    );
  }
}
