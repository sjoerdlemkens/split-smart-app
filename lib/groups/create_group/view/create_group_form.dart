import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/groups/create_group/create_group.dart';

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({super.key});

  @override
  State<CreateGroupForm> createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: const Key('createGroup_nameInput_textField'),
              onChanged: (name) => context
                  .read<CreateGroupBloc>()
                  .add(CreateGroupNameChanged(name)),
              decoration: InputDecoration(
                labelText: 'Group Name',
                hintText: 'Enter group name',
                errorText: state.name.displayError?.toString(),
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
          ],
        );
      },
    );
  }
}
