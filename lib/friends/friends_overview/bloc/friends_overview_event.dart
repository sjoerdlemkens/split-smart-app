part of 'friends_overview_bloc.dart';

sealed class FriendsOverviewEvent extends Equatable {
  const FriendsOverviewEvent();

  @override
  List<Object> get props => [];
}

class LoadFriends extends FriendsOverviewEvent {
  const LoadFriends();
}