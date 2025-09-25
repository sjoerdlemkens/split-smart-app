
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:split_smart_app/friends/add_friend/add_friend.dart';

final class AddFriendForm extends StatelessWidget {
  const AddFriendForm({super.key});

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
            errorText: state.email.displayError?.toString(),
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
