import 'package:album/router/app_router.gr.dart';
import 'package:album/router/pages_models/single_album_page.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Albums'
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Альбомы'
                ),
              ),
              Column(
                children: [
                  for(int i = 0; i <= 3; i++ )
                    GestureDetector(
                      onTap: () => {
                        print(i),
                        context.router.push(SingleAlbumRoute(albumId: i))
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            color: Colors.green.shade200,
                            child: Center(
                              child: Text (
                                  'Альбом номер $i'
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),


                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
