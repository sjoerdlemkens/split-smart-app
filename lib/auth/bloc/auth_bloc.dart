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
    on<Authenticated>(_onAuthenticated);
    on<Unauthenticated>(_onUnauthenticated);
  }

  void _onAuthInit(
    AuthInit event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await _authRepo.isAuthenticated();

    if (isAuthenticated) {
      add(const Authenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  /// Handle the auth status changes from the auth repository
  void _onAuthStatusChanged(
    AuthStatus status,
  ) =>
      add(
        status == AuthStatus.authenticated
            ? const Authenticated()
            : const Unauthenticated(),
      );

  /// Handle the authenticated event
  void _onAuthenticated(
    Authenticated event,
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
    Unauthenticated event,
    Emitter<AuthState> emit,
  ) =>
      emit(AuthUnauthenticated());

  @override
  Future<void> close() {
    _authStatusSub.cancel();
    return super.close();
  }
}
