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

  late List<List<Map<String, dynamic>>> sheets;
  late double sheetsWidth;
  late double sheetsHeight;

  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {

    if (event is InitEvent){
      print('$event from init');
      await _updateFieldsFromHiveDb();
      yield AlbumRedactorUpdateAlbum([sheets, sheetsWidth, sheetsHeight]);

    }

    else if (event is GetAlbumRedactorNaturalSheet) {
      print('$event from sheet preview');
      yield AlbumRedactorShowNaturalSheet(event.sheet);

    } else if (event is GetAlbumRedactorPlaceholderParams) {
      print('${event} from sheet natural');
      print('${event.props}');


      if (event.props[0] != 0) {
        event.props.add(sheetsWidth);
        event.props.add(sheetsHeight);
        print(event.props);
      }
      //TODO пофиксить подгрузку старого изображения при сохранении нового
      imageCache!.clear();

      yield AlbumRedactorShowPopupSheetRedactor(event.props);

      // yield AlbumRedactorShowPopupSheetRedactor([event.proportion]);


    } else if (event is GetUpdatedAlbum) {
      print('$event from show general dialog');
      var albumBox = await Hive.openBox<Album>('box_for_album');
      final tempAlbumBox = albumBox.getAt(0);
      await _updatePlaceholderState(albumBox, event.props[0]);
      await _updateFieldsFromHiveDb();
      yield AlbumRedactorUpdateAlbum([sheets, sheetsWidth, sheetsHeight]);


      final eventPropsArgs = event.props[0] as Map;
      yield AlbumRedactorShowNaturalSheet([
        tempAlbumBox!.sheets[eventPropsArgs['sheetIndex']],
        eventPropsArgs['sheetIndex'],
        sheetsWidth/sheetsHeight,
      ]);
    }
  }

  Future _updateFieldsFromHiveDb() async {
    var albumBox = await Hive.openBox<Album>('box_for_album');
      sheets = albumBox.getAt(0)!.sheets;
      sheetsWidth = albumBox.getAt(0)!.sheetsWidth;
      sheetsHeight = albumBox.getAt(0)!.sheetsHeight;
  }

  Future? _deleteImage(placeHolderParams) async {
    final directory = await getExternalStorageDirectory();
    final imagesPath = '${directory!.path}/SavedAlbumImages';
    final fileForDeleting = File(
        '$imagesPath/albumImage${placeHolderParams['sheetIndex']}${placeHolderParams['placeholderIndex']}.png');
    await fileForDeleting.delete(recursive: true);
  }

  Future? _updatePlaceholderState(box, placeHolderParams) async {
    //TODO Динамическая подгрузка индекса альбома
    // print('${placeHolderParams.props[0]} from _updatePlaceholderState');
    var tempAlbumBox = box.getAt(0);
    List<List<Map<String, dynamic>>> tempSheets = [];

    // tempAlbumBox!.sheets
    //TODO Оптимизация условия загрузки изображения в бд
    for (int i = 0; i < tempAlbumBox!.sheets.length; i++) {
      if (i != placeHolderParams['sheetIndex']) {
        tempSheets.add(tempAlbumBox!.sheets[i]);
      } else {
        List<Map<String, dynamic>> tempSheet = [];
        for (int j = 0; j < tempAlbumBox!.sheets[i].length; j++) {
          if (j != placeHolderParams['placeholderIndex']) {
            tempSheet.add(tempAlbumBox!.sheets[i][j]);
          } else {
            var tempPlaceHolder = tempAlbumBox!.sheets[i][j];
            if (placeHolderParams['saveFlag'] == true) {
              tempPlaceHolder['image'] = placeHolderParams['image'];
            } else {
              tempPlaceHolder['image'] = '';
              await _deleteImage(placeHolderParams);
            }

            tempSheet.add(tempPlaceHolder);
          }
        }
        tempSheets.add(tempSheet);
      }
    }


    box.putAt(
        0,
        Album()
          ..sheetsWidth = tempAlbumBox!.sheetsWidth
          ..sheetsHeight = tempAlbumBox.sheetsHeight
          ..sheets = tempSheets);

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
