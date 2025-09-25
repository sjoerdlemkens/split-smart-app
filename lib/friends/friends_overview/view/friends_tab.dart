import 'package:flutter/material.dart';
import 'package:split_smart_app/friends/add_friend/add_friend.dart';
import 'package:split_smart_app/friends/friends_overview/view/friends_overview.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 1,
          title: const Text('Friends'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddFriendDialog(context),
            ),
          ],
        ),
        const Expanded(
          child: FriendsOverview(),
        ),
      ],
    );
  }

  Future<void> _showAddFriendDialog(BuildContext context) async {
    final result = await AddFriendDialog.show(context);
    if (result == true) _onFriendAdded();
  }

  void _onFriendAdded() {
    // TODO: Refresh the friends list
  }
}
