import 'package:equatable/equatable.dart';

abstract class AlbumRedactorEvent extends Equatable {
  const AlbumRedactorEvent();
}

class GetAlbumRedactorNaturalSheet extends AlbumRedactorEvent {
  final List<Object> sheetAndId;

  const GetAlbumRedactorNaturalSheet(this.sheetAndId);

  @override
  List<Object> get props =>sheetAndId;
}

class GetAlbumRedactorPlaceholderProportion extends AlbumRedactorEvent {
  final List<Object> proportion;

  const GetAlbumRedactorPlaceholderProportion(this.proportion);

  @override
  List<Object> get props => proportion;
}