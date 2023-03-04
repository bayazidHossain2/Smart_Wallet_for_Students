import 'package:flutter/material.dart';
import 'package:smart_wallet/HomePage/User.dart';
import 'package:smart_wallet/common.dart';

import 'Home.dart';
import 'Market.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appBarBalanceText = 'Balance';
  double displayHeight = 0.0;
  double displayWidth = 0.0;
  int index = 0;
  List<Widget> pages = [
    Home(),
    Market1(),
    User(),
  ];

  @override
  Widget build(BuildContext context) {
    displayHeight = MediaQuery.of(context).size.height;
    displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Wallet',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          Center(
              child: Text(
            appBarBalanceText,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: pages[index],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: blue,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
