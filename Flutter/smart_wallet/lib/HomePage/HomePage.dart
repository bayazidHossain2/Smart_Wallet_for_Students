import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Database/db.dart';
import 'package:smart_wallet/HomePage/User.dart';
import 'package:smart_wallet/common.dart';

import '../Models/Market.dart';
import 'Home.dart';
import 'Market.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //leading: Image.asset('images/wallet_icon.png'),
        title: Text(
          'Smart Wallet',

          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          Center(
              child: GestureDetector(
            onTap: () async {
              if (appBarBalanceText == 'Balance') {
                print('Balance button clicked');
                final prefs = await SharedPreferences.getInstance();
                final activeId = await prefs.getInt(MarketFields.currentMarket);
                final balanceList =
                    await WalletDatabase.instance.readBalance(activeId ?? 0);
                appBarBalanceText = balanceList[0].toString() + ' ৳';
                upperText[0] = balanceList[1].toString() + ' ৳';
                upperText[1] = balanceList[2].toString() + ' ৳';
                upperText[2] = balanceList[3].toString() + ' ৳';
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => HomePage())));
              } else {
                print('Balance button clicked');
                appBarBalanceText = 'Balance';
                upperText[0] = 'SPEND';
                upperText[1] = 'DEPOSIT';
                upperText[2] = 'SAVE';
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => HomePage())));
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                appBarBalanceText,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
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
