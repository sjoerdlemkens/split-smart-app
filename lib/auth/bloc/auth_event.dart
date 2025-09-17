part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to initialize the auth bloc
class AuthInit extends AuthEvent {
  const AuthInit();
}
