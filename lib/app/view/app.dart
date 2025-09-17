import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/auth/bloc/auth_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          context.read<AuthRepository>(),
          context.read<UserRepository>(),
        )..add(const AuthInit()),
        child: const AppView(),
      ),
    );
  }
}
