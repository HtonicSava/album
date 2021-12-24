import 'package:equatable/equatable.dart';

abstract class AuthorizationState extends Equatable{
  const AuthorizationState();
}

class AuthorizationStateInit extends AuthorizationState{

  const AuthorizationStateInit();

  @override
  List<Object?> get props => [];
}

class AuthorizationStateError extends AuthorizationState{

  const AuthorizationStateError();

  @override
  List<Object?> get props => [];

}

class AuthorizationStateProcess extends AuthorizationState{

  const AuthorizationStateProcess();

  @override
  List<Object?> get props => [];

}
