import 'dart:async';
import 'package:bloc/bloc.dart';
import 'custom_color_event.dart';
import 'custom_color_state.dart';

class CustomColorBloc extends Bloc<CustomColorEvent, CustomColorState> {

  CustomColorBloc(CustomColorState initialState) : super(initialState);

  @override
  CustomColorState get initialState => CustomColorStateInitial();

  @override
  Stream<CustomColorState> mapEventToState(
        CustomColorEvent event,
      ) async* {

    if (event is GetBigSheet){
      print('event worked with ${event.width}');
      yield CustomColorStateLoaded([event.width, event.color]);
    }

  }
}