import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_redactor_event.dart';
import 'album_redactor_state.dart';

class AlbumRedactorBloc extends Bloc<AlbumRedactorEvent, AlbumRedactorState> {
  AlbumRedactorBloc() : super(const SheetShowed());

  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {
    if (event is AlbumRedactorShowSheet) {
      yield* _sheetLoadedToState(event);
    }
  }

  Stream<AlbumRedactorState> _sheetLoadedToState(
      AlbumRedactorShowSheet event) async* {
    final List<Object> newSheet = event.sheet;
    yield SheetShowed(sheet: newSheet);
  }
}
