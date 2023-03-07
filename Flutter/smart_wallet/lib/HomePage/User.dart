import 'package:flutter/material.dart';
import 'package:smart_wallet/Authentication/LoginPage.dart';
import 'package:smart_wallet/HomePage/UserLogedinPage.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: isLogin
            ? UserLoginedPage()
            : LoginPage(),
    );
  }
}