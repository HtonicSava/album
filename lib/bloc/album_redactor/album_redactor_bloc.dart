import 'dart:io';

import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'album_redactor_event.dart';
import 'album_redactor_state.dart';

class AlbumRedactorBloc extends Bloc<AlbumRedactorEvent, AlbumRedactorState> {
  AlbumRedactorBloc(AlbumRedactorState initialState) : super(initialState);

  AlbumRedactorState get initialState => const AlbumRedactorStateInitial();

  late List sheets;
  late double _sheetsWidth;
  late double _sheetsHeight;
  late int _chosenAlbumIndex;
  late List<Album> _albums;



  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {
    if (event is InitEvent){
      print('$event from init');
      await _updateFieldsFromHiveDb(event.albumIndex);
      _chosenAlbumIndex = event.albumIndex;
      yield AlbumRedactorUpdateAlbum([sheets, _sheetsWidth, _sheetsHeight], albumName: _albums[_chosenAlbumIndex].name);
    }

    else if ( event is GetAlbums) {
      print('$event from GetAlbums');
      _albums = await _updateAlbumsFromHiveDb();


      yield AlbumRedactorShowAlbums(albums: _albums);
    }

    else if (event is GetAlbumRedactorNaturalSheet) {
      print('$event from sheet preview');
      //TODO Различие между передачей данных с помощью props и полей класса события
      yield AlbumRedactorShowNaturalSheet(event.sheetAndId);

    } else if (event is GetAlbumRedactorPlaceholderParams) {
      print('${event} from sheet natural');
      print('${event.props}');


      if (event.props[0] != 0) {
        event.props.add(_sheetsWidth);
        event.props.add(_sheetsHeight);
        print(event.props);
      }
      //TODO пофиксить подгрузку старого изображения при сохранении нового
      imageCache!.clear();

      yield AlbumRedactorShowPopupSheetRedactor(event.props);

      // yield AlbumRedactorShowPopupSheetRedactor([event.proportion]);


    } else if (event is GetUpdatedAlbum) {
      print('$event from show general dialog');
      Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
      final tempAlbumBox = albumBox.getAt(_chosenAlbumIndex);

      await _updatePlaceholderState(albumBox, event.props[0], _chosenAlbumIndex);
      await _updateFieldsFromHiveDb(_chosenAlbumIndex);
      yield AlbumRedactorUpdateAlbum([sheets, _sheetsWidth, _sheetsHeight],  albumName: _albums[_chosenAlbumIndex].name);




      final eventPropsArgs = event.props[0] as Map;
      yield AlbumRedactorShowNaturalSheet([
        tempAlbumBox!.sheets[eventPropsArgs['sheetIndex']],
        eventPropsArgs['sheetIndex'],
        _sheetsWidth/_sheetsHeight,
      ]);
    }
  }

  Future _updateAlbumsFromHiveDb() async {
    Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
    List<Album> _tempAlbums = [];
    for (Album album in albumBox.values){
      _tempAlbums.add(album);
    }
    return _tempAlbums;
  }

  Future _updateFieldsFromHiveDb(albumIndex) async {
    //TODO Оптимизировать обращения к бд посредством выноса albumBox в атрибут класса?
    Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
    sheets = albumBox.getAt(albumIndex)!.sheets;
    _sheetsWidth = albumBox.getAt(albumIndex)!.sheetsWidth;
    _sheetsHeight = albumBox.getAt(albumIndex)!.sheetsHeight;
  }

  Future? _deleteImage(placeHolderParams) async {
    final directory = await getExternalStorageDirectory();
    final imagesPath = '${directory!.path}/SavedAlbumImages';
    final fileForDeleting = File(
        '$imagesPath/albumImage$_chosenAlbumIndex${placeHolderParams['sheetIndex']}${placeHolderParams['placeholderIndex']}.png');
    await fileForDeleting.delete(recursive: true);
  }

  Future? _updatePlaceholderState(box, placeHolderParams, albumIndex) async {
    // print('${placeHolderParams.props[0]} from _updatePlaceholderState');
    var tempAlbumBox = box.getAt(albumIndex);
    List tempSheets = [];

    //TODO Оптимизация условия загрузки изображения в бд
    for (int i = 0; i < tempAlbumBox!.sheets.length; i++) {
      if (i != placeHolderParams['sheetIndex']) {

        tempSheets.add(tempAlbumBox!.sheets[i]);
      } else {
        Map tempSheet = {
          'name': tempAlbumBox.sheets[i]['name'],
          'pages': [],
        };
        for (int j = 0; j < tempAlbumBox!.sheets[i]['pages'].length; j++) {
          if (j != placeHolderParams['placeholderIndex']) {
            tempSheet['pages'].add(tempAlbumBox!.sheets[i]['pages'][j]);
          } else {
            var tempPlaceHolder = tempAlbumBox!.sheets[i]['pages'][j];
            if (placeHolderParams['saveFlag'] == true) {
              tempPlaceHolder['image'] = placeHolderParams['image'];
            } else {
              tempPlaceHolder['image'] = '';
              await _deleteImage(placeHolderParams);
            }

            tempSheet['pages'].add(tempPlaceHolder);
          }
        }
        tempSheets.add(tempSheet);
      }
    }


    box.putAt(
        albumIndex,
        Album()
          ..sheetsWidth = tempAlbumBox!.sheetsWidth
          ..sheetsHeight = tempAlbumBox.sheetsHeight
          ..sheets = tempSheets
          ..sheetsNumber = tempAlbumBox.sheetsNumber
          ..name = tempAlbumBox.name
    );



    // print('${box.getAt(0)!.sheets} from show general dialog before update DB');
    // print('${box.getAt(0)!.sheets[0][0]} from show general dialog before update DB');
    // box.putAt(
    //     0,
    //     Album()
    //       ..sheetsWidth = tempAlbumBox!.sheetsWidth
    //       ..sheetsHeight = tempAlbumBox.sheetsHeight
    //       ..sheets = [[{'width': 0.5, 'height': 0.5, 'top': 0.0, 'left': 0.0, 'image': 'image'}], ]
    // );
    // print('${box.getAt(0)!.sheets} from show general dialog after update DB');
    // print('${box.getAt(0)!.sheets[0][0]} from show general dialog after update DB');
  }
}