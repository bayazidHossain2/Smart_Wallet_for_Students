import 'package:flutter/material.dart';
import 'package:smart_wallet/Authentication/LoginPage.dart';
import 'package:smart_wallet/Authentication/Registration.dart';
import 'package:smart_wallet/HomePage/UserLogedinPage.dart';

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