import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/friends/add_friend/bloc/add_friend_bloc.dart';
import 'package:split_smart_app/friends/add_friend/view/add_friend_form.dart';
import 'package:friends_repository/friends_repository.dart';

class AddFriendDialog extends StatelessWidget {
  const AddFriendDialog({
    super.key,
  });

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const AddFriendDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFriendBloc(
        friendsRepository: context.read<FriendsRepository>(),
      ),
      child: const _AddFriendDialogView(),
    );
  }
}

class _AddFriendDialogView extends StatelessWidget {
  const _AddFriendDialogView();

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Friend request sent successfully!'),
      ),
    );
  }

  void _onFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to send friend request. Please try again.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFriendBloc, AddFriendState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          _onSuccess(context);
        } else if (state.status == FormzSubmissionStatus.failure) {
          _onFailure(context);
        }
      },
      child: AlertDialog(
        title: const Text('Add Friend'),
        content: const AddFriendForm(),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          const _AddFriendButton(),
        ],
      ),
    );
  }
}

class _AddFriendButton extends StatelessWidget {
  const _AddFriendButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendBloc, AddFriendState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          onPressed: state.status == FormzSubmissionStatus.inProgress
              ? null
              : () =>
                  context.read<AddFriendBloc>().add(const AddFriendSubmitted()),
          child: state.status == FormzSubmissionStatus.inProgress
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Send Request'),
        );
      },
    );
  }
}
