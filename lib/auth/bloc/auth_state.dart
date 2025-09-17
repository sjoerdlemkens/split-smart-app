part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Authentication status is unknown
class AuthUnknown extends AuthState {}

/// User is not authenticated
class AuthUnauthenticated extends AuthState {}

/// User is authenticated
class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
