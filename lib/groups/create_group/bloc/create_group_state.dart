part of 'create_group_bloc.dart';

class CreateGroupState extends Equatable {
  const CreateGroupState({
    this.name = const RequiredText.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final RequiredText name;
  final FormzSubmissionStatus status;

  CreateGroupState copyWith({
    RequiredText? name,
    FormzSubmissionStatus? status,
  }) {
    return CreateGroupState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, status];
}
