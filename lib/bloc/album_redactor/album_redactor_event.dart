import 'package:equatable/equatable.dart';
import 'package:image/image.dart' as imageLib;

abstract class AlbumRedactorEvent extends Equatable {
  const AlbumRedactorEvent();
}

class GetAlbums extends AlbumRedactorEvent{

  const GetAlbums();

  @override

  List<Object?> get props => [];

}

class InitEvent extends AlbumRedactorEvent{
  final int albumIndex;
  const InitEvent( this.albumIndex);

  @override
  List<Object> get props => [albumIndex];
}

class GetAlbumRedactorNaturalSheet extends AlbumRedactorEvent {
  final List<Object> sheetAndId;


  const GetAlbumRedactorNaturalSheet(this.sheetAndId);

  @override
  List<Object> get props =>sheetAndId;
}

class GetAlbumRedactorPlaceholderParams extends AlbumRedactorEvent {
  final List<Object> proportion;

  const GetAlbumRedactorPlaceholderParams(this.proportion);

  @override
  List<Object> get props => proportion;
}

class GetUpdatedAlbum extends AlbumRedactorEvent {
  final List<Object> updatedPlaceholderParams;
  final imageLib.Image? image;

  const GetUpdatedAlbum(this.updatedPlaceholderParams, {this.image});

  @override
  List<Object?> get props => updatedPlaceholderParams;

}

