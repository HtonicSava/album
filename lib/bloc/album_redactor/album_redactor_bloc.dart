import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'album_redactor_event.dart';
import 'album_redactor_state.dart';

class AlbumRedactorBloc extends Bloc<AlbumRedactorEvent, AlbumRedactorState> {
  AlbumRedactorBloc(AlbumRedactorState initialState) : super(initialState);

  AlbumRedactorState get initialState =>  AlbumRedactorStateInitial();

  @override
  Stream<AlbumRedactorState> mapEventToState(AlbumRedactorEvent event) async* {
    if (event is GetAlbumRedactorNaturalSheet) {
      print('$event from bloc dialog');
      yield AlbumRedactorShowNaturalSheet(sheet: event.sheetAndId);
    } else if (event is GetAlbumRedactorPlaceholderProportion) {
      print('${event} from sheet natural');
      yield AlbumRedactorShowPopupSheetRedactor(event.proportion);
    }
  }


}
