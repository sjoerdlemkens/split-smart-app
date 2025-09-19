import 'package:flutter/material.dart';
import 'package:split_smart_app/home/view/nav_bar_item.dart';

class NavBar extends StatelessWidget {
  final Function(int) onTabSelected;

  const NavBar({
    super.key,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.group,
            label: 'Friends',
            onPressed: () => onTabSelected(0),
          ),
          NavBarItem(
            icon: Icons.groups,
            label: 'Groups',
            onPressed: () => onTabSelected(1),
          ),
          const SizedBox(width: 30),
          NavBarItem(
            icon: Icons.history,
            label: 'Activity',
            onPressed: () => onTabSelected(2),
          ),
          NavBarItem(
            icon: Icons.settings,
            label: 'Settings',
            onPressed: () => onTabSelected(3),
          ),
        ],
      ),
    );
  }
}
