import 'package:digital_wallet/Authentication/Registration.dart';
import 'package:digital_wallet/Pages/HelpPages.dart';
import 'package:digital_wallet/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Center(
            child: Text(
              'Login',
              style: headingTextDesing,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _form_key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Email',
                            hintText: 'Enter your Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'User Email required.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Passwoard required.';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('Forget Password clicked.');
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Login clicked.');

                          if (_form_key.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Login successful'),
                              backgroundColor: Colors.green,
                            ));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationPage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                4), // Set the border radius
                            // You can also use other shape options like BeveledRectangleBorder, StadiumBorder, etc.
                          ),
                          backgroundColor: Colors.teal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 200,
          child: ElevatedButton.icon(
            onPressed: (() {}),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red.shade300),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Set the border radius
                // You can also use other shape options like BeveledRectangleBorder, StadiumBorder, etc.
              ),
              backgroundColor: Colors.teal.shade100,
            ),
            label: Text('Sign Up with Google'),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  print('Register clicked');
                  isRegister = true;
                  pageIndex = 2;
                  refreshPage(context);
                  //Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => RegistrationPage())));
                },
                child: Text(
                  'Register First.',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => HelpPages())));
                },
                child: Text(
                  'Help.',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
