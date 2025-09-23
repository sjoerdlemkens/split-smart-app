import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/friends/add_friend/bloc/add_friend_bloc.dart';
import 'package:split_smart_app/misc/misc.dart';

class AddFriendDialog extends StatelessWidget {
  const AddFriendDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const AddFriendDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFriendBloc(),
      child: const _AddFriendDialogView(),
    );
  }
}

class _AddFriendDialogView extends StatelessWidget {
  const _AddFriendDialogView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFriendBloc, AddFriendState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Friend request sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to send friend request. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Add Friend'),
        content: const _AddFriendForm(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          BlocBuilder<AddFriendBloc, AddFriendState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return TextButton(
                onPressed: state.status == FormzSubmissionStatus.inProgress
                    ? null
                    : () => context
                        .read<AddFriendBloc>()
                        .add(const AddFriendSubmitted()),
                child: state.status == FormzSubmissionStatus.inProgress
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Send Request'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AddFriendForm extends StatelessWidget {
  const _AddFriendForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendBloc, AddFriendState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('addFriend_emailInput_textField'),
          onChanged: (email) =>
              context.read<AddFriendBloc>().add(AddFriendEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter friend\'s email address',
            errorText: state.email.displayError?.text,
            border: const OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            if (state.status == FormzSubmissionStatus.initial &&
                state.email.isValid) {
              context.read<AddFriendBloc>().add(const AddFriendSubmitted());
            }
          },
        );
      },
    );
  }
}

extension EmailValidationErrorX on EmailValidationError {
  String get text {
    switch (this) {
      case EmailValidationError.invalid:
        return 'Please enter a valid email address';
    }
  }
}
