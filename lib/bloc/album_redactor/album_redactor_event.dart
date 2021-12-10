import 'package:equatable/equatable.dart';

abstract class AlbumRedactorEvent extends Equatable {
  const AlbumRedactorEvent();
}

class InitEvent extends AlbumRedactorEvent{
  const InitEvent();

  @override
  List<Object> get props => [];
}

class GetAlbumRedactorNaturalSheet extends AlbumRedactorEvent {
  final List<Object> sheet;

  const GetAlbumRedactorNaturalSheet(this.sheet);

  @override
  List<Object> get props => sheet;
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

  @override
  List<Object?> get props => updatedPlaceholderParams;

}

