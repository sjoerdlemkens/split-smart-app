import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/auth/bloc/auth_bloc.dart';
import 'package:split_smart_app/home/view/home_page.dart';
import 'package:split_smart_app/sign_in/view/sign_in_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _AppNavigator(),
    );
  }
}

class _AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return switch (state) {
          AuthUnknown() => Container(),
          AuthUnauthenticated() => const SignInPage(),
          AuthAuthenticated() => const HomePage(),
        };
      },
    );
  }
}
