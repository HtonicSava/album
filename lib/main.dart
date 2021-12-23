import 'dart:io';

import 'package:album/UI/screens/album_redactor.dart';
import 'package:album/UI/screens/authorization.dart';
import 'package:album/UI/screens/personal_account.dart';
import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/album_redactor/album_redactor_bloc.dart';
import 'bloc/album_redactor/album_redactor_state.dart';

void main() async {
  Album album = Album()
    ..sheetsNumber = 7
    ..name = 'Альбом от команды №1'
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

  Album albumSecond = Album()
    ..sheetsNumber = 2
    ..name = 'Альбом от команды №2'
    ..sheetsHeight = 4400.0
    ..sheetsWidth = 3200.0
    ..sheets = [
      [
        {'width': 0.9, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'image': ''},
        {'width': 0.9, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'image': ''},
      ],
      [
        {'width': 0.9, 'height': 0.9, 'top': 0.5, 'left': 0.5, 'image': ''},
      ],
    ];

  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  //TODO Заполнение пустой БД
  var albumBox = await Hive.openBox<Album>('box_for_albums');

  // albumBox.add(album);
  // albumBox.add(albumSecond);

  // print(albumBox.values);

  // for (Album album in albumBox.values){
  //   print(album.name);
  // }

  // albumBox.deleteFromDisk();

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
  bool _authorizated = false;
  int _chosenAlbumIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _handleAuthorisationTapped() {
      // print(_authorizated);
      setState(() {
        _authorizated = true;
      });
    }

    void _handleAlbumTapped(albumNumber) {
      setState(() {
        _chosenAlbumIndex = albumNumber;
      });
      // print(_chosenAlbum);
    }

    // print(_chosenAlbum);
    // print(_chosenAlbum.runtimeType);

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        foregroundColor: Color(0xFFA5A5A5),
        backgroundColor: Color(0xFFDDDDDD),
      )),
      debugShowCheckedModeBanner: false,
      title: 'Онлайн альбом',
      home: BlocProvider(
        create: (context) => AlbumRedactorBloc(AlbumRedactorStateInitial()),
        child: Navigator(
          pages: [
            MaterialPage(
              key: ValueKey('PersonalAccountPage'),
              child: PersonalAccount(
                onAlbumTapped: _handleAlbumTapped,
              ),
            ),
            if (_authorizated == false)
              AuthorisationPage(onTapped: _handleAuthorisationTapped),
            // MaterialPage(
            //   child: AlbumRedactor(),
            // ),
            if (_chosenAlbumIndex != -1)
              AlbumRedactorPage(chosenAlbum: _chosenAlbumIndex),
          ],
          onPopPage: (route, result) {
            print("from onPopMethod ${route} ${result}");
            if (!route.didPop(result)) {
              return false;
            }

            setState(() {
              // _authorizated = false;
              _chosenAlbumIndex = -1;
            });

            return true;
          },
        ),
      ),
    );

    // return const  PersonalAccount();
  }
}

class AlbumRedactorPage extends Page {
  final int chosenAlbum;

  const AlbumRedactorPage({LocalKey? key, required this.chosenAlbum})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return AlbumRedactor(albumIndex: chosenAlbum);
      },
    );
  }
}

class AuthorisationPage extends Page {
  final VoidCallback onTapped;

  const AuthorisationPage({required this.onTapped, LocalKey? key})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return Authorization(
          onTapped: onTapped,
        );
      },
    );
  }
}

// class PersonalAccountPage extends Page {
//   @override
//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(
//       settings: this,
//       builder: (BuildContext context) {
//         return PersonalAccount();
//       },
//     );
//   }
// }
