import 'package:equatable/equatable.dart';

abstract class AlbumRedactorState extends Equatable{
  const AlbumRedactorState();

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

class AlbumRedactorUpdateAlbum extends AlbumRedactorState{
  final List<Object> albumInfo;

  const AlbumRedactorUpdateAlbum(this.albumInfo);

  @override
  List<Object> get props => albumInfo;
}
