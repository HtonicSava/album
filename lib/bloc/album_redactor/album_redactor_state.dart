import 'package:equatable/equatable.dart';

abstract class AlbumRedactorState extends Equatable{
  final sheet = [];
  AlbumRedactorState();



}

class AlbumRedactorStateInitial extends AlbumRedactorState{


  AlbumRedactorStateInitial();

  @override
  List<Object> get props => [];

}

class AlbumRedactorShowNaturalSheet extends AlbumRedactorState {
  @override
  final sheet;
  final sheetId;


  AlbumRedactorShowNaturalSheet({required this.sheet, this.sheetId});

  @override
  List<Object> get props => [sheet];



}

class AlbumRedactorShowPopupSheetRedactor extends AlbumRedactorState {
  final List<Object> proportion;


  AlbumRedactorShowPopupSheetRedactor(this.proportion);
  @override
  List<Object> get props => proportion;

}
