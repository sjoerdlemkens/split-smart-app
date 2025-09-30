import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:groups_repository/groups_repository.dart';
import 'package:split_smart_app/friends/friends_overview/bloc/friends_overview_bloc.dart';
import 'package:split_smart_app/groups/groups_overview/bloc/groups_overview_bloc.dart';
import 'package:split_smart_app/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routePath = '/home';
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FriendsOverviewBloc(
            friendsRepository: context.read<FriendsRepository>(),
          )..add(const LoadFriends()),
        ),
        BlocProvider(
          create: (context) => GroupsOverviewBloc(
            groupsRepository: context.read<GroupsRepository>(),
          )..add(const LoadGroups()),
        ),
      ],
      child: _ProvidedHomePage(),
    );
  }
}

class _ProvidedHomePage extends StatefulWidget {
  @override
  State<_ProvidedHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_ProvidedHomePage> {
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
