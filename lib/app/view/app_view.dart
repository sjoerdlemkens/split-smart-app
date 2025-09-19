import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:split_smart_app/app/router/app_router.dart';
import 'package:split_smart_app/auth/bloc/auth_bloc.dart';
import 'package:user_repository/user_repository.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final AuthBloc authBloc;
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(
      context.read<AuthRepository>(),
      context.read<UserRepository>(),
    )..add(const AuthInit());

    router = AppRouter.createRouter(authBloc);
  }

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        title: 'Split Smart',
        debugShowCheckedModeBanner: false,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
      ),
    );
  }
}
