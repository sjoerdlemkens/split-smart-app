part of 'add_friend_bloc.dart';

sealed class AddFriendEvent extends Equatable {
  const AddFriendEvent();

  @override
  List<Object> get props => [];
}

class AddFriendEmailChanged extends AddFriendEvent {
  const AddFriendEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class AddFriendSubmitted extends AddFriendEvent {
  const AddFriendSubmitted();
}
