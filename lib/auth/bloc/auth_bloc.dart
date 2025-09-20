import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;
  final UserRepository _userRepo;
  late final StreamSubscription<AuthStatus> _authStatusSub;

  AuthBloc(
    AuthRepository authRepository,
    UserRepository userRepository,
  )   : _authRepo = authRepository,
        _userRepo = userRepository,
        super(AuthUnknown()) {
    /// Start listening to the auth status stream
    _authStatusSub = _authRepo.authStatusStream.listen(_onAuthStatusChanged);

    /// Handle the auth status changed event
    on<AuthInit>(_onAuthInit);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<_Authenticated>(_onAuthenticated);
    on<_Unauthenticated>(_onUnauthenticated);
  }

  void _onAuthInit(
    AuthInit event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await _authRepo.isAuthenticated();

    if (isAuthenticated) {
      add(const _Authenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepo.logout();
    emit(AuthUnauthenticated());
    add(const _Unauthenticated());
  }

  /// Handle the auth status changes from the auth repository
  void _onAuthStatusChanged(
    AuthStatus status,
  ) =>
      add(
        status == AuthStatus.authenticated
            ? const _Authenticated()
            : const _Unauthenticated(),
      );

  /// Handle the authenticated event
  void _onAuthenticated(
    _Authenticated event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _userRepo.getLoggedInUser();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  /// Handle the unauthenticated event
  void _onUnauthenticated(
    _Unauthenticated event,
    Emitter<AuthState> emit,
  ) =>
      emit(AuthUnauthenticated());

  @override
  Future<void> close() {
    _authStatusSub.cancel();
    return super.close();
  }
}
