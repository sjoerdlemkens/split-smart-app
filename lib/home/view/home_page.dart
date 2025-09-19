import 'package:flutter/material.dart';
import 'package:split_smart_app/home/view/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routePath = '/home';
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Expense',
        elevation: 2.0,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
