import 'dart:io';

import 'package:album/UI/screens/authorisation.dart';
import 'package:album/UI/screens/personal_account.dart';
import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'UI/screens/home.dart';

void main() async {
  Album album = Album()
    ..sheetsHeight = 4400.0
    ..sheetsWidth = 3200.0
    ..sheets = [
      [
        {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'image': ''},
        {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'image': ''},
      ],
      [
        {'width': 0.75, 'height': 0.5454, 'top': 0.5, 'left': 0.5, 'image': ''},
      ],
      [
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.5,
          'left': 0.5,
          'image': ''
        },
      ],
      [
        {
          'width': 0.1875,
          'height': 0.13635,
          'top': 0.5,
          'left': 0.5,
          'image': ''
        },
      ],
      [
        {
          'width': 0.7776,
          'height': 0.2916,
          'top': 0.5,
          'left': 0.5,
          'image': ''
        },
      ],
      [
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.1,
          'left': 0.15,
          'image': ''
        },
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.1,
          'left': 0.85,
          'image': ''
        },
        {
          'width': 0.8313,
          'height': 0.2727,
          'top': 0.55,
          'left': 0.5,
          'image': ''
        },
      ],
      [
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.1,
          'left': 0.15,
          'image': ''
        },
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.1,
          'left': 0.85,
          'image': ''
        },
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.55,
          'left': 0.15,
          'image': ''
        },
        {
          'width': 0.375,
          'height': 0.2727,
          'top': 0.55,
          'left': 0.85,
          'image': ''
        },
      ],
    ];

  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  //TODO Заполнение пустой БД
  var albumBox = await Hive.openBox<Album>('box_for_album');

  // albumBox.add(album);

  // albumBox.deleteFromDisk();

  // print(albumBox.getAt(0)!.sheets);

  runApp(const OnlineAlbum());
}

class OnlineAlbum extends StatefulWidget {
  const OnlineAlbum({
    Key? key,
  }) : super(key: key);

  @override
  State<OnlineAlbum> createState() => _OnlineAlbumState();
}

class _OnlineAlbumState extends State<OnlineAlbum> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Онлайн альбом',
        home: Navigator(
          pages: [
            MaterialPage(
              child: PersonalAccount(),
            )
          ],
        ));

    // return const  PersonalAccount();
  }
}
