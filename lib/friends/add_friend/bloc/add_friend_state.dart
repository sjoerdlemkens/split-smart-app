part of 'add_friend_bloc.dart';

class AddFriendState extends Equatable {
  const AddFriendState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [email, status];

  AddFriendState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
  }) {
    return AddFriendState(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }
}
