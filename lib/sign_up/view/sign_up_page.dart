import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/sign_up/sign_up.dart';
import 'package:split_smart_app/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(),
        child: const SignUpForm(),
      ),
    );
  }
}
