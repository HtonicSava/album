import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable{
  const AuthorizationState();
}

class AuthorizationStateUserRemoved extends AuthorizationState{
  const AuthorizationStateUserRemoved();

  @override
  List<Object?> get props => [];
}

class AuthorizationStateAuthorizated extends AuthorizationState{

  const AuthorizationStateAuthorizated();

  @override
  List<Object?> get props => [];
}

class AuthorizationStateInit extends AuthorizationState{

  const AuthorizationStateInit();

  @override
  List<Object?> get props => [];
}

// TODO implement
class AuthorizationStateError extends AuthorizationState{

  const AuthorizationStateError();

  @override
  List<Object?> get props => [];

}

// TODO implement

class AuthorizationStateProcess extends AuthorizationState{

  const AuthorizationStateProcess();

  @override
  List<Object?> get props => [];

}

class AuthorizationStateShowUserData extends AuthorizationState{

  final String login;

  const AuthorizationStateShowUserData( {required this.login,});

  @override
  List<Object?> get props => [login];
}