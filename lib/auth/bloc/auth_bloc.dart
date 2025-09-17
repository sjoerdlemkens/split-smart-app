import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    AuthRepository authRepository,
    UserRepository userRepository,
  )   : _authRepo = authRepository,
        _userRepo = userRepository,
        super(AuthUnknown()) {
    on<AuthInit>(
      (event, emit) async {
        final isAuthenticated = await _authRepo.isAuthenticated();

        if (!isAuthenticated) {
          emit(AuthUnauthenticated());
        } else {
          final user = await _userRepo.getLoggedInUser();
          emit(AuthAuthenticated(user));
        }
      },
    );
  }

  final AuthRepository _authRepo;

  final UserRepository _userRepo;
}
