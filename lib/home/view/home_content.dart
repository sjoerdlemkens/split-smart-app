import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/friends/friends_overview/friends_overview.dart';
import 'package:split_smart_app/settings/settings.dart';
import 'package:friends_repository/friends_repository.dart';

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
        return const Text('Groups');
      case 2:
        return const Text('Activity');
      case 3:
        return const SettingsTab();
    }

    throw Exception('Invalid tab index: $selectedTab');
  }
}
