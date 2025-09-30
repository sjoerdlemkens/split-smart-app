import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/groups/groups_overview/bloc/groups_overview_bloc.dart';
import 'package:split_smart_app/groups/groups_overview/view/groups_overview.dart';
import 'package:split_smart_app/groups/create_group/create_group.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 1,
          title: const Text('Groups'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateGroupDialog(context),
            ),
          ],
        ),
        const Expanded(
          child: GroupsOverview(),
        ),
      ],
    );
  }

  Future<void> _showCreateGroupDialog(BuildContext context) async {
    final result = await CreateGroupDialog.show(context);
    if (result == true && context.mounted) _onGroupCreated(context);
  }

  void _onGroupCreated(BuildContext context) {
    context.read<GroupsOverviewBloc>().add(const LoadGroups());
  }
}
