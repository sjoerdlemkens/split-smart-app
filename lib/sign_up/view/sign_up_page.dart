import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/sign_up/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String routePath = '/signUp';
  static const String routeName = 'signUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            context.read<AuthRepository>(),
          ),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
