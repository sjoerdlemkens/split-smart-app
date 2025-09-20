import 'package:flutter/material.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/sign_in/sign_in.dart';
import 'package:split_smart_app/sign_in/view/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const String routePath = '/signIn';
  static const String routeName = 'signIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            context.read<AuthRepository>(),
          ),
          child: const SignInForm(),
        ),
      ),
    );
  }
}
