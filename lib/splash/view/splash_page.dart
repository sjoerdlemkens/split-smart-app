import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String routeName = 'splash';
  static const String routePath = '/splash';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Page')),
    );
  }
}
