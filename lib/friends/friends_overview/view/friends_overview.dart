import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:split_smart_app/friends/friends_overview/bloc/friends_overview_bloc.dart';

class FriendsOverview extends StatelessWidget {
  const FriendsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsOverviewBloc(
        friendsRepository: context.read<FriendsRepository>(),
      )..add(const LoadFriends()),
      child: const _ProvidedFriendsOverview(),
    );
  }
}

class _ProvidedFriendsOverview extends StatelessWidget {
  const _ProvidedFriendsOverview();

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Text(error.toString()),
    );
  }

  Widget _buildLoaded(List<Friend> friends) {
    if (friends.isEmpty) {
      return const Center(
        child: Text('No friends'),
      );
    }

    return ListView.builder(
      itemCount: friends.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ListTile(
        title: Text(friends[index].email),
        onTap: () {
          print('tapped friend');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsOverviewBloc, FriendsOverviewState>(
      builder: (context, state) => switch (state) {
        FriendsOverviewInitial() || FriendsOverviewLoading() => _buildLoading(),
        FriendsOverviewError() => _buildError(state.error),
        FriendsOverviewLoaded() => _buildLoaded(state.friends),
      },
    );
  }
}
