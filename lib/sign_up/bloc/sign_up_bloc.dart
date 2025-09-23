import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:split_smart_app/misc/misc.dart';
import 'package:split_smart_app/sign_up/models/models.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(
    AuthRepository authRepository,
  )   : _authRepo = authRepository,
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepo;

  void _onEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password, state.confirmPassword]),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = Password.dirty(event.password);
    final confirmPassword = ConfirmPassword.dirty(
      password: event.password,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([state.email, password, confirmPassword]),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: event.confirmPassword,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([state.email, state.password, confirmPassword]),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authRepo.signUp(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
