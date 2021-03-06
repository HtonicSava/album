import 'dart:io';

import 'package:album/data/models/hive_album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:image/image.dart' as image_lib;
import 'album_redactor_event.dart';
import 'album_redactor_state.dart';

class AlbumRedactorBloc extends Bloc<AlbumRedactorEvent, AlbumRedactorState> {
  AlbumRedactorBloc(AlbumRedactorState initialState) : super(initialState);

  AlbumRedactorState get initialState => const AlbumRedactorStateInitial();

  late List _sheets;
  late double _sheetsWidth;
  late double _sheetsHeight;
  late int _chosenAlbumIndex;
  late List<Album> _albums;

  Stream<AlbumRedactorState> _getTheAlbumHandler(event) async* {
    await _updateFieldsFromHiveDb(event.albumIndex);
    _chosenAlbumIndex = event.albumIndex;
    yield AlbumRedactorUpdateAlbum(
        albumName: _albums[_chosenAlbumIndex].name,
        coverAlbumLink: _albums[_chosenAlbumIndex].coverAlbumLink,
        sheets: _sheets,
        sheetsHeight: _sheetsHeight,
        sheetsWidth: _sheetsWidth);
  }

  Stream<AlbumRedactorState> _getAlbumsHandler(event) async* {
    _albums = await _updateAlbumsFromHiveDb();
    yield AlbumRedactorShowAlbums(albums: _albums);
  }

  Stream<AlbumRedactorState> _getAlbumRedactorNaturalSheetHandler(
      event) async* {
    yield AlbumRedactorShowNaturalSheet(
        sheetWidth: event.sheetWidth,
        sheet: event.sheet,
        sheetHeight: event.sheetHeight,
        sheetIndex: event.sheetIndex);
  }

  Stream<AlbumRedactorState> _getAlbumRedactorPlaceholderParams(event) async* {
    if (event.props[0] != 0) {
      event.props.add(_sheetsWidth);
      event.props.add(_sheetsHeight);
      // print(event.props);
    }
    //TODO пофиксить подгрузку старого изображения при сохранении нового
    imageCache!.clear();
    yield AlbumRedactorShowPopupSheetRedactor(event.props);
  }

  Stream<AlbumRedactorState> _getUpdatedAlbum(event) async* {
    Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
    final tempAlbumBox = albumBox.getAt(_chosenAlbumIndex);
    print(event.image);
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

    //TODO Рефакторинг event.updatedPlaceholderParams[0] на event.updatedPlaceholderParams, возможно ли избавиться от AlbumRedactorShowNaturalSheet в этом стриме?

    await _updatePlaceholderState(albumBox, event.updatedPlaceholderParams[0], _chosenAlbumIndex, event.image);
    await _updateFieldsFromHiveDb(_chosenAlbumIndex);
    yield AlbumRedactorUpdateAlbum(
        sheetsWidth: _sheetsWidth,
        albumName: _albums[_chosenAlbumIndex].name,
        coverAlbumLink: _albums[_chosenAlbumIndex].coverAlbumLink,
        sheets: _sheets,
        sheetsHeight: _sheetsHeight);
    // final eventPropsArgs = event.props[0] as Map;
    yield AlbumRedactorShowNaturalSheet(
        sheetHeight: _sheetsHeight,
        sheet: tempAlbumBox!.sheets[event.updatedPlaceholderParams[0]['sheetIndex']],
        sheetIndex: event.updatedPlaceholderParams[0]['sheetIndex'],
        sheetWidth: _sheetsWidth);
  }

  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {
    switch (event.runtimeType) {
      case GetTheAlbum:
        print('$event from GetTheAlbum');
        yield* _getTheAlbumHandler(event);
        break;
      case GetAlbums:
        print('$event from GetAlbums');
        yield* _getAlbumsHandler(event);
        break;
      case GetAlbumRedactorNaturalSheet:
        print('$event from sheet preview');
        yield* _getAlbumRedactorNaturalSheetHandler(event);
        break;
      case GetAlbumRedactorPlaceholderParams:
        print('${event} from sheet natural');
        yield* _getAlbumRedactorPlaceholderParams(event);
        break;
      case GetUpdatedAlbum:
        print('$event from show general dialog');
        yield* _getUpdatedAlbum(event);
        break;
      //При разделении предпросмотра и редактировании в коде ниже нет необходимости
      // final tempAlbumBox = albumBox.getAt(_chosenAlbumIndex);

      // final eventPropsArgs = event.props[0] as Map;
      // yield AlbumRedactorShowNaturalSheet([
      //   tempAlbumBox!.sheets[eventPropsArgs['sheetIndex']],
      //   eventPropsArgs['sheetIndex'],
      //   _sheetsWidth/_sheetsHeight,
      // ]);
    }
  }

  Future _updateAlbumsFromHiveDb() async {
    Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
    List<Album> _tempAlbums = [];
    for (Album album in albumBox.values) {
      _tempAlbums.add(album);
    }
    return _tempAlbums;
  }

  Future _updateFieldsFromHiveDb(albumIndex) async {
    //TODO Оптимизировать обращения к бд посредством выноса albumBox в атрибут класса?
    Box<Album> albumBox = await Hive.openBox<Album>('box_for_albums');
    _sheets = albumBox.getAt(albumIndex)!.sheets;
    _sheetsWidth = albumBox.getAt(albumIndex)!.sheetsWidth;
    _sheetsHeight = albumBox.getAt(albumIndex)!.sheetsHeight;
  }

  Future? _deleteImage(placeHolderParams) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesPath = '${directory.path}/SavedAlbumImages';
    final fileForDeleting = File(
        '$imagesPath/albumImage$_chosenAlbumIndex${placeHolderParams['sheetIndex']}${placeHolderParams['placeholderIndex']}.png');
    await fileForDeleting.delete(recursive: true);
  }

  Future _saveImageToDirectory(
      //TODO оптимизировать с помощью проверки существования директории
      image, Map placeholderParams, int albumIndex) async {
    final directory = await getApplicationDocumentsDirectory();
    final myImagePath = '${directory.path}/SavedAlbumImages';
    await Directory(myImagePath).create();

    image_lib.Image? resizedImage = image_lib.copyResize(image!,
        width: (placeholderParams)['imageResizeParams']['width'].round(),
        height: (placeholderParams)['imageResizeParams']['height'].round());

    image_lib.Image croppedImage = image_lib.copyCrop(
        resizedImage,
        (placeholderParams)['imageStartCordsForCropping']['x'].round(),
        (placeholderParams)['imageStartCordsForCropping']['y'].round(),
        (placeholderParams)['croppingSizes']['width'].round(),
        (placeholderParams)['croppingSizes']['height'].round());

    File('$myImagePath/albumImage$albumIndex${(placeholderParams)['sheetIndex']}${(placeholderParams)['placeholderIndex']}.png')
        .writeAsBytesSync(image_lib.encodePng(croppedImage));

    (placeholderParams)['image'] =
        '$myImagePath/albumImage$albumIndex${(placeholderParams)['sheetIndex']}${(placeholderParams)['placeholderIndex']}.png';
  }

  Future? _updatePlaceholderState(box, placeHolderParams, albumIndex, image) async {
    // print('${placeHolderParams.props[0]} from _updatePlaceholderState');
    var tempAlbumBox = box.getAt(albumIndex);
    List tempSheets = [];
    //TODO Реализовать похожим образом на удаление загрузку изображения
    //TODO Оптимизация условия загрузки изображения в бд
    for (int i = 0; i < tempAlbumBox!.sheets.length; i++) {
      if (i != placeHolderParams['sheetIndex']) {
        tempSheets.add(tempAlbumBox!.sheets[i]);
      } else {
        Map tempSheet = {
          'name': tempAlbumBox.sheets[i]['name'],
          'pages': [],
          'sheetCoverLink': tempAlbumBox.sheets[i]['sheetCoverLink']
        };
        for (int j = 0; j < tempAlbumBox!.sheets[i]['pages'].length; j++) {
          if (j != placeHolderParams['placeholderIndex']) {
            tempSheet['pages'].add(tempAlbumBox!.sheets[i]['pages'][j]);
          } else {
            var tempPlaceHolder = tempAlbumBox!.sheets[i]['pages'][j];
            if (placeHolderParams['saveFlag'] == true) {
              await _saveImageToDirectory(image, placeHolderParams, albumIndex);
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
          ..coverAlbumLink = tempAlbumBox.coverAlbumLink);

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
