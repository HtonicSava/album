import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'album_redactor_event.dart';
import 'album_redactor_state.dart';

class AlbumRedactorBloc extends Bloc<AlbumRedactorEvent, AlbumRedactorState> {
  AlbumRedactorBloc(AlbumRedactorState initialState) : super(initialState);

  AlbumRedactorState get initialState => const AlbumRedactorStateInitial();

  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {
    if (event is AlbumRedactorShowSheet) {
      yield NaturalSheetShowed(event.sheet);
    }
  }
}
