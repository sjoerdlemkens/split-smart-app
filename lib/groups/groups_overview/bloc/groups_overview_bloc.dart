import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groups_repository/groups_repository.dart';

part 'groups_overview_event.dart';
part 'groups_overview_state.dart';

class GroupsOverviewBloc
    extends Bloc<GroupsOverviewEvent, GroupsOverviewState> {
  final GroupsRepository _groupsRepository;

  GroupsOverviewBloc({
    required GroupsRepository groupsRepository,
  })  : _groupsRepository = groupsRepository,
        super(GroupsOverviewInitial()) {
    on<LoadGroups>(_onLoadGroups);
  }

  Future<void> _onLoadGroups(
    LoadGroups event,
    Emitter<GroupsOverviewState> emit,
  ) async {
    emit(GroupsOverviewLoading());

    try {
      final groups = await _groupsRepository.getGroups();
      emit(GroupsOverviewLoaded(groups));
    } catch (e) {
      emit(GroupsOverviewError(e));
    }
  }
}
