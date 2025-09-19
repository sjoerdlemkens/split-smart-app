import 'package:flutter/material.dart';
import 'package:split_smart_app/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routePath = '/home';
  static const String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

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
      bottomNavigationBar: NavBar(
        onTabSelected: (index) => setState(
          () => _selectedTab = index,
        ),
      ),
      body: HomeContent(
        selectedTab: _selectedTab,
      ),
    );
  }
}
