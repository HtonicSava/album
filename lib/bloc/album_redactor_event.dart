abstract class AlbumRedactorEvent {
  const AlbumRedactorEvent();

  List<Object> get props => [];
}

class AlbumRedactorShowSheet extends AlbumRedactorEvent {
  final List<Object> sheet;

  const AlbumRedactorShowSheet(this.sheet);

  @override
  List<Object> get props {
    print('$props');
    print('event is working');
    return sheet;
  }

  @override
  String toString() => 'TodoAdded { todo: $sheet }';
}
