part of 'friends_overview_bloc.dart';

sealed class FriendsOverviewState extends Equatable {
  const FriendsOverviewState();

  @override
  List<Object> get props => [];
}

final class FriendsOverviewInitial extends FriendsOverviewState {}

final class FriendsOverviewLoading extends FriendsOverviewState {}

final class FriendsOverviewError extends FriendsOverviewState {
  const FriendsOverviewError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

final class FriendsOverviewLoaded extends FriendsOverviewState {
  const FriendsOverviewLoaded(this.friends);

  final List<Friend> friends;

  @override
  List<Object> get props => [friends];
}
