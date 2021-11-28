abstract class AlbumRedactorState {
  const AlbumRedactorState();

  List<Object> get props => [];
}

class SheetShowed extends AlbumRedactorState {
  final List<Object> sheet;

  const SheetShowed({this.sheet = const []});

  @override
  List<Object> get props => sheet;

  @override
  String toString() => 'SheetShowed { sheet: $sheet }';
}
