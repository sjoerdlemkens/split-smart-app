part of 'create_group_bloc.dart';

sealed class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupNameChanged extends CreateGroupEvent {
  const CreateGroupNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class CreateGroupSubmitted extends CreateGroupEvent {
  const CreateGroupSubmitted();
}
