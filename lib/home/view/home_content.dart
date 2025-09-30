import 'package:flutter/material.dart';
import 'package:split_smart_app/friends/friends_overview/friends_overview.dart';
import 'package:split_smart_app/groups/groups_overview/groups_overview.dart';
import 'package:split_smart_app/settings/settings.dart';

class HomeContent extends StatelessWidget {
  final int selectedTab;

  const HomeContent({
    super.key,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedTab) {
      case 0:
        return const FriendsTab();
      case 1:
        return const GroupsTab();
      case 2:
        return const Text('Activity');
      case 3:
        return const SettingsTab();
    }

    throw Exception('Invalid tab index: $selectedTab');
  }
}
