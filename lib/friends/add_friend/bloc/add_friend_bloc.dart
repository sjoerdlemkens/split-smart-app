import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/misc/misc.dart';

part 'add_friend_event.dart';
part 'add_friend_state.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  AddFriendBloc() : super(const AddFriendState()) {
    on<AddFriendEmailChanged>(_onEmailChanged);
    on<AddFriendSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    AddFriendEmailChanged event,
    Emitter<AddFriendState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email])
          ? FormzSubmissionStatus.initial
          : FormzSubmissionStatus.initial,
    ));
  }

  void _onSubmitted(
    AddFriendSubmitted event,
    Emitter<AddFriendState> emit,
  ) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email])
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    ));

    if (Formz.validate([email])) {
      // TODO: Implement actual friend addition logic here
      // For now, just simulate success
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
