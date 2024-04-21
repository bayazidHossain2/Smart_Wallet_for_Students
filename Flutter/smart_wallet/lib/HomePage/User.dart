import 'package:digital_wallet/Authentication/LoginPage.dart';
import 'package:digital_wallet/Authentication/Registration.dart';
import 'package:digital_wallet/HomePage/UserLogedinPage.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: isLogin
            ? UserLoginedPage()
            : isRegister
              ? RegistrationPage()
              : LoginPage(),
    );
  }
}