import 'package:equatable/equatable.dart';

abstract class AlbumRedactorEvent extends Equatable {
  const AlbumRedactorEvent();
}

class GetAlbumRedactorNaturalSheet extends AlbumRedactorEvent {
  final List<Object> sheet;

  const GetAlbumRedactorNaturalSheet(this.sheet);

  @override
  List<Object> get props => sheet;
}

class GetAlbumRedactorPlaceholderProportion extends AlbumRedactorEvent {
  final List proportion;

  const GetAlbumRedactorPlaceholderProportion(this.proportion);

  @override
  List get props => proportion;
}