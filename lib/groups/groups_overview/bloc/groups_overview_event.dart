part of 'groups_overview_bloc.dart';

sealed class GroupsOverviewEvent extends Equatable {
  const GroupsOverviewEvent();

  @override
  List<Object> get props => [];
}

class LoadGroups extends GroupsOverviewEvent {
  const LoadGroups();
}
