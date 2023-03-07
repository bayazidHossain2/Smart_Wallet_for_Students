import 'package:flutter/material.dart';

class UserLoginedPage extends StatefulWidget {
  const UserLoginedPage({super.key});

  @override
  State<UserLoginedPage> createState() => _UserLoginedPageState();
}

class _UserLoginedPageState extends State<UserLoginedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Thank you for login. This Feature is not build yeat')),
    );
  }
}