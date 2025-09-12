import 'package:flutter/material.dart';
import 'package:split_smart_app/home/home.dart';
import 'package:split_smart_app/sign_up/view/sign_up_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}
