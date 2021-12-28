import 'dart:io';

import 'package:album/UI/screens/album_preview.dart';
import 'package:album/UI/screens/album_redactor.dart';
import 'package:album/UI/screens/authorization.dart';
import 'package:album/UI/screens/personal_account.dart';
import 'package:album/bloc/authorization/authorization_bloc.dart';
import 'package:album/bloc/authorization/authorization_state.dart';
import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/album_redactor/album_redactor_bloc.dart';
import 'bloc/album_redactor/album_redactor_state.dart';
import 'data/models/hive_user.dart';

// TODO Объединить SheetNaturalPreview и SheetNaturalRedactor в один файл
void main() async {
  // {
  //   'name': 'Страница 1',
  // 'pages': [],
  // },
  Album album = Album()
    ..sheetsNumber = 7
    ..name = 'Альбом от команды №1'
    ..sheetsHeight = 4400.0
    ..sheetsWidth = 3200.0
    ..coverAlbumLink = 'assets/img/album1.png'
    ..sheets = [
      {
        'name': 'Страница 1',
        'sheetCoverLink': 'assets/img/sheetback1.png',
        'pages': [
          {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'image': ''},
          {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'image': ''},
        ],
      },
      {
        'name': 'Страница 2',
        'sheetCoverLink': 'assets/img/sheetback1.png',
        'pages': [
          {
            'width': 0.75,
            'height': 0.5454,
            'top': 0.5,
            'left': 0.5,
            'image': ''
          },
        ],
      },
      {
        'name': 'Страница 3',
        'sheetCoverLink': 'assets/img/sheetback1.png',
        'pages': [
          {
            'width': 0.375,
            'height': 0.2727,
            'top': 0.5,
            'left': 0.5,
            'image': ''
          },
        ],
      },
      {
        'name': 'Страница 4',
        'sheetCoverLink': 'assets/img/sheetback1.png',
        'pages': [
          {
            'width': 0.1875,
            'height': 0.13635,
            'top': 0.5,
            'left': 0.5,
            'image': ''
          },
        ],
      },
      {
        'name': 'Страница 5',
        'sheetCoverLink': 'assets/img/sheetback3.png',
        'pages': [
          {
            'width': 0.7776,
            'height': 0.2916,
            'top': 0.5,
            'left': 0.5,
            'image': ''
          },
        ],
      },
      {
        'name': 'Страница 6',
        'sheetCoverLink': 'assets/img/sheetback3.png',

        'pages': [
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
      },
      {
        'name': 'Страница 7',
        'sheetCoverLink': 'assets/img/sheetback3.png',

        'pages': [
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
      },
    ];

  Album albumSecond = Album()
    ..sheetsNumber = 2
    ..name = 'Альбом от команды №2'
    ..sheetsHeight = 4400.0
    ..sheetsWidth = 3200.0
    ..coverAlbumLink = 'assets/img/album2.png'
    ..sheets = [
      {
        'name': 'Страница 1',
        'sheetCoverLink': 'assets/img/sheetback2.png',
        'pages': [
          {'width': 0.9, 'height': 0.2, 'top': 0.7, 'left': 0.5, 'image': ''},
          {'width': 0.9, 'height': 0.2, 'top': 0.1, 'left': 0.5, 'image': ''},
        ],
      },
      {
        'name': 'Страница 2',
        'sheetCoverLink': 'assets/img/sheetback2.png',
        'pages': [
          {
            'width': 0.9,
            'height': 0.9,
            'top': 0.5,
            'left': 0.5,
            'image': ''
          },
        ],
      },
    ];

  // User user = User()
  //   ..login = 'EGOR'
  //   ..password = '1234';

  await Hive.initFlutter();
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(UserAdapter());

  //TODO Заполнение пустой БД
  var albumBox = await Hive.openBox<Album>('box_for_albums');
  var userBox = await Hive.openBox<User>('box_for_user');

  // userBox.add(user);
  //
  albumBox.add(album);
  albumBox.add(albumSecond);

  // print(albumBox.values);

  // for (Album album in albumBox.values){
  //   print(album.name);
  // }

  // albumBox.deleteFromDisk();
  // userBox.deleteFromDisk();

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
  int _choosenSheetIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _completeAuthorization() {
      // print(_authorizated);
      setState(() {
        _authorizated = true;
      });
    }

    void _exitAuthorization() {
      setState(() {
        _authorizated = false;
      });
    }

    void _handleAlbumTapped(albumNumber) {
      setState(() {
        _chosenAlbumIndex = albumNumber;
      });
      // print(_chosenAlbum);
    }

    void _handleSheetTapped(sheetIndex) {
      setState(() {
        _choosenSheetIndex = sheetIndex;
      });
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AlbumRedactorBloc(const AlbumRedactorStateInitial()),
          ),
          BlocProvider(
              create: (context) =>
                  AuthorizationBloc(const AuthorizationStateInit())),
        ],
        child: Navigator(
          pages: [
            MaterialPage(
              key: ValueKey('PersonalAccountPage'),
              child: PersonalAccount(
                onAlbumTapped: _handleAlbumTapped,
                onAccountExit: _exitAuthorization,
              ),
            ),
            if (_authorizated == false)
              AuthorisationPage(onTapped: _completeAuthorization),
            // MaterialPage(
            //   child: AlbumRedactor(),
            // ),
            if (_chosenAlbumIndex != -1)
              AlbumPreviewPage(
                  chosenAlbum: _chosenAlbumIndex,
                  onSheetTapped: _handleSheetTapped),

            if (_choosenSheetIndex != -1)
              AlbumRedactorPage(
                  chosenAlbum: _chosenAlbumIndex,
                  sheetIndex: _choosenSheetIndex),
          ],
          onPopPage: (route, result) {
            print("from onPopMethod ${route.settings.runtimeType} ${result}");
            if (!route.didPop(result)) {
              return false;
            }
            if (route.settings.runtimeType == AlbumPreviewPage) {
              setState(() {
                _chosenAlbumIndex = -1;
              });
            }
            if (route.settings.runtimeType == AlbumRedactorPage) {
              setState(() {
                _choosenSheetIndex = -1;
              });
            }
            // setState(() {
            //   _chosenAlbumIndex = -1;
            //   _choosenSheetIndex = -1;
            // });

            return true;
          },
        ),
      ),
    );

    // return const  PersonalAccount();
  }
}

class AlbumPreviewPage extends Page {
  final int chosenAlbum;
  final ValueSetter onSheetTapped;

  const AlbumPreviewPage(
      {LocalKey? key, required this.chosenAlbum, required this.onSheetTapped})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return AlbumPreview(
          albumIndex: chosenAlbum,
          onSheetTapped: onSheetTapped,
        );
      },
    );
  }
}

class AlbumRedactorPage extends Page {
  final int chosenAlbum;
  final int sheetIndex;

  const AlbumRedactorPage(
      {LocalKey? key, required this.chosenAlbum, required this.sheetIndex})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return AlbumRedactor(
          albumIndex: chosenAlbum,
          sheetIndex: sheetIndex,
        );
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
