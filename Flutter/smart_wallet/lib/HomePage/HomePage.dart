import 'package:digital_wallet/Database/db.dart';
import 'package:digital_wallet/HomePage/User.dart';
import 'package:digital_wallet/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        actions: [
          Center(
              child: GestureDetector(
            onTap: () async {
              if (appBarBalanceText == 'Balance'||appBarBalanceText == 'টাকা দেখুন') {
                print('Balance button clicked');
                final prefs = await SharedPreferences.getInstance();
                final activeId = await prefs.getInt(MarketFields.currentMarket);
                final balanceList =
                    await WalletDatabase.instance.readBalance(activeId ?? 0);
                appBarBalanceText = ((languageIndex ==0)?getBangla(balanceList[0].toString()):balanceList[0].toString()) + ' ৳';
                upperText[0] = ((languageIndex ==0)?getBangla(balanceList[1].toString()):balanceList[1].toString()) + ' ৳';
                upperText[1] = ((languageIndex ==0)?getBangla(balanceList[2].toString()):balanceList[2].toString()) + ' ৳';
                upperText[2] = ((languageIndex ==0)?getBangla(balanceList[3].toString()):balanceList[3].toString()) + ' ৳';
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => HomePage())));
              } else {
                print('Balance button clicked');
                appBarBalanceText = (languageIndex ==0)?'টাকা দেখুন':'Balance';
                upperText[0] = 'খরচ';
                upperText[1] = 'জমা';
                upperText[2] = 'সঞ্চয়';
                upperText[3] = 'SPEND';
                upperText[4] = 'DEPOSIT';
                upperText[5] = 'SAVE';
                refreshPage(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                appBarBalanceText,
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16, color: Colors.white),
              ),
            ),
          )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: blue,
        onTap: (value) {
          setState(() {
            pageIndex = value;
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
