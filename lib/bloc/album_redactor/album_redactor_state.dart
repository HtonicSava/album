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
  final List<Object> sheet;


  const AlbumRedactorShowNaturalSheet(this.sheet);

  @override
  List<Object> get props => sheet;


}

class AlbumRedactorShowPopupSheetRedactor extends AlbumRedactorState {
  final List<Object> proportion;


  const AlbumRedactorShowPopupSheetRedactor(this.proportion);
  @override
  List<Object> get props => proportion;

}
