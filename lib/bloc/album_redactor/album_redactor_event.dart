import 'package:equatable/equatable.dart';

abstract class AlbumRedactorEvent extends Equatable {
  const AlbumRedactorEvent();
}

class GetAlbums extends AlbumRedactorEvent{

  const GetAlbums();

  @override

  List<Object?> get props => [];

}

class GetTheAlbum extends AlbumRedactorEvent{
  final int albumIndex;

  const GetTheAlbum( this.albumIndex);

  @override
  List<Object> get props => [albumIndex];
}

class GetAlbumRedactorNaturalSheet extends AlbumRedactorEvent {

  final Map sheet;
  final int sheetIndex;
  final double sheetWidth;
  final double sheetHeight;


  const GetAlbumRedactorNaturalSheet( {required this.sheet, required this.sheetIndex, required this.sheetWidth, required this.sheetHeight});

  @override
  List<Object> get props =>[sheetHeight,sheet,sheetWidth,sheetIndex];
}

class GetAlbumRedactorPlaceholderParams extends AlbumRedactorEvent {
  final List<Object> proportion;

  const GetAlbumRedactorPlaceholderParams(this.proportion);

  @override
  List<Object> get props => proportion;
}

class GetUpdatedAlbum extends AlbumRedactorEvent {
  final List<Object> updatedPlaceholderParams;

  const GetUpdatedAlbum(this.updatedPlaceholderParams);
  //TODO поффиксить получение updatedPlaceholderParams из props
  @override
  List<Object?> get props => updatedPlaceholderParams;

}

