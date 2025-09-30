part of 'groups_overview_bloc.dart';

sealed class GroupsOverviewState extends Equatable {
  const GroupsOverviewState();

  @override
  List<Object> get props => [];
}

final class GroupsOverviewInitial extends GroupsOverviewState {}

final class GroupsOverviewLoading extends GroupsOverviewState {}

final class GroupsOverviewError extends GroupsOverviewState {
  const GroupsOverviewError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

final class GroupsOverviewLoaded extends GroupsOverviewState {
  const GroupsOverviewLoaded(this.groups);

  final List<Group> groups;

  @override
  List<Object> get props => [groups];
}
