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
  final List<Object> sheetInfo;


  const AlbumRedactorShowNaturalSheet(this.sheetInfo);

  @override
  List<Object> get props => sheetInfo;


}

class AlbumRedactorShowPopupSheetRedactor extends AlbumRedactorState {
  final List<Object> proportion;


  const AlbumRedactorShowPopupSheetRedactor(this.proportion);
  @override
  List<Object> get props => proportion;

}

// TODO обновить props
class AlbumRedactorUpdateAlbum extends AlbumRedactorState{
  final List<Object> albumInfo;
  final String albumName;

  const AlbumRedactorUpdateAlbum(this.albumInfo, {required this.albumName});

  @override
  List<Object> get props => albumInfo;
}
