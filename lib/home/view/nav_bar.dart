import 'package:flutter/material.dart';
import 'package:split_smart_app/home/view/nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

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
            onPressed: () {},
          ),
          NavBarItem(
            icon: Icons.groups,
            label: 'Groups',
            onPressed: () {},
          ),
          const SizedBox(width: 30),
          NavBarItem(
            icon: Icons.history,
            label: 'Activity',
            onPressed: () {},
          ),
          NavBarItem(
            icon: Icons.settings,
            label: 'Settings',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
