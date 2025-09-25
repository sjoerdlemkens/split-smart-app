import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/misc/misc.dart';
import 'package:friends_repository/friends_repository.dart';

part 'add_friend_event.dart';
part 'add_friend_state.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  AddFriendBloc({
    required FriendsRepository friendsRepository,
  })  : _friendsRepository = friendsRepository,
        super(const AddFriendState()) {
    on<AddFriendEmailChanged>(_onEmailChanged);
    on<AddFriendSubmitted>(_onSubmitted);
  }

  final FriendsRepository _friendsRepository;

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

  Future<void> _onSubmitted(
    AddFriendSubmitted event,
    Emitter<AddFriendState> emit,
  ) async {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email])
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    ));

    final isValid = Formz.validate([email]);

    if (isValid) {
      try {
        final enteredEmail = email.value;
        await _friendsRepository.addFriend(enteredEmail);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (error) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
