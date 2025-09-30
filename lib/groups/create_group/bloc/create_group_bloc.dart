import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/misc/misc.dart';
import 'package:groups_repository/groups_repository.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc({
    required GroupsRepository groupsRepository,
  })  : _groupsRepository = groupsRepository,
        super(const CreateGroupState()) {
    on<CreateGroupNameChanged>(_onNameChanged);
    on<CreateGroupSubmitted>(_onSubmitted);
  }

  final GroupsRepository _groupsRepository;

  void _onNameChanged(
    CreateGroupNameChanged event,
    Emitter<CreateGroupState> emit,
  ) {
    final name = RequiredText.dirty(event.name);
    emit(state.copyWith(name: name));
  }

  Future<void> _onSubmitted(
    CreateGroupSubmitted event,
    Emitter<CreateGroupState> emit,
  ) async {
    final name = RequiredText.dirty(state.name.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name])
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    ));

    final isValid = Formz.validate([name]);

    if (isValid) {
      try {
        final groupName = name.value;

        await _groupsRepository.createGroup(
          name: groupName,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (error) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
