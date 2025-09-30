import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:groups_repository/groups_repository.dart';
import 'package:split_smart_api/split_smart_api.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final SplitSmartApi apiClient;

  @override
  void initState() {
    super.initState();
    apiClient = SplitSmartApi.development();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(apiClient: apiClient),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(apiClient: apiClient),
        ),
        RepositoryProvider(
          create: (context) => FriendsRepository(apiClient: apiClient),
        ),
        RepositoryProvider(
          create: (context) => GroupsRepository(apiClient: apiClient),
        ),
      ],
      child: const AppView(),
    );
  }
}
