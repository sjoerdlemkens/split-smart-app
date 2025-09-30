import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/groups/create_group/bloc/create_group_bloc.dart';
import 'package:split_smart_app/groups/create_group/view/create_group_form.dart';
import 'package:groups_repository/groups_repository.dart';

class CreateGroupDialog extends StatelessWidget {
  const CreateGroupDialog({
    super.key,
  });

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const CreateGroupDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGroupBloc(
        groupsRepository: context.read<GroupsRepository>(),
      ),
      child: const _CreateGroupDialogView(),
    );
  }
}

class _CreateGroupDialogView extends StatelessWidget {
  const _CreateGroupDialogView();

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Group created successfully!'),
      ),
    );
  }

  void _onFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to create group. Please try again.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupBloc, CreateGroupState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          _onSuccess(context);
        } else if (state.status == FormzSubmissionStatus.failure) {
          _onFailure(context);
        }
      },
      child: AlertDialog(
        title: const Text('Create Group'),
        content: const SizedBox(
          width: 400,
          child: CreateGroupForm(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          const _CreateGroupButton(),
        ],
      ),
    );
  }
}

class _CreateGroupButton extends StatelessWidget {
  const _CreateGroupButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextButton(
          onPressed: state.status == FormzSubmissionStatus.inProgress
              ? null
              : () => context
                  .read<CreateGroupBloc>()
                  .add(const CreateGroupSubmitted()),
          child: state.status == FormzSubmissionStatus.inProgress
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create Group'),
        );
      },
    );
  }
}
