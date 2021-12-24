
import 'package:album/bloc/authorization/authorization_event.dart';
import 'package:album/bloc/authorization/authorization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState>{

  AuthorizationBloc(AuthorizationState initialState) : super(initialState);

  AuthorizationState get initialState => const AuthorizationStateInit();

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {

    if (event is AuthorizationEventCheckCurrentUser){
      yield* _checkCurrentAuthorization();
    }

  }

  Stream<AuthorizationState> _checkCurrentAuthorization() async* {

    yield const AuthorizationStateInit();
  }
}