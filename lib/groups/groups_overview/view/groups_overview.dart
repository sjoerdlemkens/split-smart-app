import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groups_repository/groups_repository.dart';
import 'package:split_smart_app/groups/groups_overview/bloc/groups_overview_bloc.dart';

class GroupsOverview extends StatelessWidget {
  const GroupsOverview({super.key});

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

  Widget _buildLoaded(List<Group> groups) {
    if (groups.isEmpty) {
      return const Center(
        child: Text('No groups'),
      );
    }

    return ListView.builder(
      itemCount: groups.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ListTile(
        title: Text(groups[index].name),
        onTap: () {
          print('tapped group: ${groups[index].name}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsOverviewBloc, GroupsOverviewState>(
      builder: (context, state) => switch (state) {
        GroupsOverviewInitial() || GroupsOverviewLoading() => _buildLoading(),
        GroupsOverviewError() => _buildError(state.error),
        GroupsOverviewLoaded() => _buildLoaded(state.groups),
      },
    );
  }
}
