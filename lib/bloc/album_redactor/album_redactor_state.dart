import 'package:equatable/equatable.dart';

abstract class AlbumRedactorState extends Equatable{
  const AlbumRedactorState();
}
class AlbumRedactorStateInitial extends AlbumRedactorState{
  const AlbumRedactorStateInitial();

  @override
  List<Object> get props => [];

}

class NaturalSheetShowed extends AlbumRedactorState {
  final List<Object> sheet;

  const NaturalSheetShowed(this.sheet);

  @override
  List<Object> get props => [sheet];

}
