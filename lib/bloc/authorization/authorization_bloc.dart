
import 'package:album/bloc/authorization/authorization_event.dart';
import 'package:album/bloc/authorization/authorization_state.dart';
import 'package:album/data/models/hive_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState>{
  //TODO Вынести инициализацию Hive Box в конструктор класса
  AuthorizationBloc(AuthorizationState initialState) : super(initialState);

  AuthorizationState get initialState => const AuthorizationStateInit();

  @override
  Stream<AuthorizationState> mapEventToState(AuthorizationEvent event) async* {

    if (event is AuthorizationEventCheckCurrentUser){
      yield* _checkCurrentAuthorization();
    } else if (event is AuthorizationEventGetLogin){
      yield* _checkUserInformation();
    } else if (event is AuthorizationEventLogin ){
      yield* _loginUser(event.login, event.password);
    } else if (event is AuthorizationEventExit){
      yield* _exit();
    }


  }

  Stream<AuthorizationState> _exit() async* {
    Box<User> user = await Hive.openBox<User>('box_for_user');
    await user.deleteFromDisk();
    yield const AuthorizationStateUserRemoved();

  }

  Stream<AuthorizationState> _checkUserInformation() async* {
    Box<User> user = await Hive.openBox<User>('box_for_user');

    if(user.isNotEmpty  && user.getAt(0) != null) {
      yield AuthorizationStateShowUserData( login: user.getAt(0)!.login);
    }
  }

  Stream<AuthorizationState> _checkCurrentAuthorization() async* {
    Box<User> user = await Hive.openBox<User>('box_for_user');
    // print("${user.isEmpty} - USER EMPTY?");
    yield  user.isEmpty ? const AuthorizationStateInit() :  const AuthorizationStateAuthorizated();
  }


  Stream<AuthorizationState> _loginUser(String login, String password) async* {
    // TODO добавить стейт загрузки
    User user = User()
      ..login = login
      ..password = password;
    var userBox = await Hive.openBox<User>('box_for_user');
    userBox.add(user);

    yield  const AuthorizationStateAuthorizated();
  }
}