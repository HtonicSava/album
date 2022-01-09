import 'dart:ffi';

import 'package:album/data/models/hive_album.dart';
import 'package:equatable/equatable.dart';

abstract class AlbumRedactorState extends Equatable{
  const AlbumRedactorState();

}

class AlbumRedactorShowAlbums extends AlbumRedactorState{
  final List<Album> albums;

  const AlbumRedactorShowAlbums({required this.albums});


  @override
  List<Object?> get props => [albums];

}

class AlbumRedactorStateInitial extends AlbumRedactorState{
  const AlbumRedactorStateInitial();

  @override
  List<Object> get props => [];

}

class AlbumRedactorShowNaturalSheet extends AlbumRedactorState {
  final Map sheet;
  final int sheetIndex;
  final double sheetWidth;
  final double sheetHeight;

  const AlbumRedactorShowNaturalSheet(
      {required this.sheet, required this.sheetIndex, required this.sheetWidth, required this.sheetHeight});

  @override
  List<Object> get props => [sheetHeight,sheet,sheetWidth,sheetIndex];
}

class AlbumRedactorShowPopupSheetRedactor extends AlbumRedactorState {
  final List<Object> proportion;


  const AlbumRedactorShowPopupSheetRedactor(this.proportion);
  @override
  List<Object> get props => proportion;

}

class AlbumRedactorUpdateAlbum extends AlbumRedactorState{
  // final List<Object> albumInfo;
  final List sheets;
  final String albumName;
  final String coverAlbumLink;
  final double sheetsHeight;
  final double sheetsWidth;

  const AlbumRedactorUpdateAlbum(   {required this.sheetsWidth, required this.sheetsHeight, required this.sheets, required this.albumName, required this.coverAlbumLink});

  @override
  List<Object> get props => [sheets, albumName, coverAlbumLink, sheetsHeight, sheetsWidth];
}
