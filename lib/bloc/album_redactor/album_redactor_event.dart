import 'package:equatable/equatable.dart';

abstract class AlbumRedactorEvent extends Equatable{
  const AlbumRedactorEvent();
}

class AlbumRedactorShowSheet extends AlbumRedactorEvent {
  final List<Object> sheet;
  const AlbumRedactorShowSheet(this.sheet);

  @override
  List<Object> get props => [sheet];


}
