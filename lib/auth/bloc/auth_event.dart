part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to initialize the authentication bloc.
/// Triggered during app startup to check authentication status
/// and restore user session from stored credentials.
class AuthInit extends AuthEvent {
  const AuthInit();
}

/// Event triggered when the user becomes authenticated.
/// This can happen through login or when a valid token is found.
class Authenticated extends AuthEvent {
  const Authenticated();
}

/// Event triggered when the user becomes unauthenticated.
/// This can happen through logout or  token expiry
class Unauthenticated extends AuthEvent {
  const Unauthenticated();
}
