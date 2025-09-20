import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:split_smart_app/sign_up/sign_up.dart';
import 'package:split_smart_app/sign_in/view/sign_in_page.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _ConfirmPasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _SignUpButton(),
            const Padding(padding: EdgeInsets.all(8)),
            _SignInLink(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (email) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email));
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('signUpForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.confirmPassword.displayError,
    );

    return TextField(
      key: const Key('signUpForm_confirmPasswordInput_textField'),
      onChanged: (confirmPassword) {
        context
            .read<SignUpBloc>()
            .add(SignUpConfirmPasswordChanged(confirmPassword));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'confirm password',
        errorText: displayError != null ? 'passwords do not match' : null,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((SignUpBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<SignUpBloc>().add(const SignUpSubmitted())
          : null,
      child: const Text('Sign Up'),
    );
  }
}

class _SignInLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '),
        TextButton(
          onPressed: () => context.go(SignInPage.routePath),
          child: const Text('Sign In'),
        ),
      ],
    );
  }
}
