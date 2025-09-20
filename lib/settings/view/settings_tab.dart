import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:split_smart_app/auth/bloc/auth_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          elevation: 1,
          title: const Text('Settings'),
        ),
        ListTile(
          title: const Text('Logout'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            final authBloc = context.read<AuthBloc>();
            authBloc.add(const AuthLogoutRequested());
          },
        ),
      ],
    );
  }
}
