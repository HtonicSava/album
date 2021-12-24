
import 'package:equatable/equatable.dart';

abstract class AuthorizationEvent extends Equatable{
  const AuthorizationEvent();
}

class AuthorizationEventCheckCurrentUser extends AuthorizationEvent{
  const AuthorizationEventCheckCurrentUser();

  @override
  List<Object?> get props => [];
}

class AuthorizationEventLogin extends AuthorizationEvent{

  final String login;
  final String password;

  const AuthorizationEventLogin({required this.login, required this.password});

  @override
  List<Object?> get props => [login, password];
}
