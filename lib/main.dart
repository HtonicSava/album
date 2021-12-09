import 'dart:io';

import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'UI/screens/home.dart';


void main() async {
  Album album = Album()
    ..sheetsHeight = 800.0
    ..sheetsWidth = 600.0
    ..sheets = [
      [
        {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'image': ''},
        {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'image': ''},
      ],
      [
        {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'image': ''},
        {'width': 0.5, 'height': 0.2, 'top': 0.4, 'left': 0.5, 'image': ''},
        {'width': 0.5, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'image': ''},
      ],
      [
        {'width': 0.33, 'height': 0.250, 'top': 0.5, 'left': 0.5, 'image': ''},
      ],
    ];

  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  //TODO Заполнение пустой БД
  var albumBox = await Hive.openBox<Album>('box_for_album');

  // albumBox.add(album);

  // albumBox.deleteFromDisk();

  // print(albumBox.getAt(0)!.sheets);



  runApp(

      const OnlineAlbum());
}

class OnlineAlbum extends StatelessWidget {
  const OnlineAlbum({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return const MaterialApp(
      title: 'Онлайн альбом',
      home: Home(),
    );
  }
}
