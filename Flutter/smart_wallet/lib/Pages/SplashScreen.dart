import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/HomePage/HomePage.dart';
import 'package:smart_wallet/common.dart';

import '../Database/db.dart';
import '../Models/Market.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    getLanguageIndex();
  }
  Future<void> getLanguageIndex() async {
    final prefs = await SharedPreferences.getInstance();
    int? _languageIndex;
    _languageIndex = prefs.getInt(languageIndexText);
    if (_languageIndex == null) {
      await prefs.setInt(languageIndexText, 0);
      languageIndex = 0;
    } else {
      languageIndex = _languageIndex;
    }

    //Market id setting
    currentMarketId = prefs.getInt(MarketFields.currentMarket);
    if (currentMarketId == null) {
      print("Null Market id----------");
      List<Market> allMarketList =
          await WalletDatabase.instance.readAllMarket();
      print('Total market find : ' + allMarketList.length.toString());
      if (allMarketList.isEmpty) {
        final market = Market(
          name: 'Default',
          creatingTime: DateTime.now(),
        );
        final currentMarket =
            await WalletDatabase.instance.createMarket(market);
        currentMarketId = currentMarket.id ?? -1;
        await prefs.setInt(MarketFields.currentMarket, currentMarketId ?? 0);
      } else {
        currentMarketId = allMarketList[0].id;
      }
      // print('Market name is : '+market.name);
      print('P says market is : ' +
          prefs.getInt(MarketFields.currentMarket).toString());
    } else {
      print('find market id is : ' + currentMarketId.toString());
    }
    await Future.delayed(const Duration(seconds: 3), (){});

    Navigator.pop(context);
    await Navigator.push(
        context, MaterialPageRoute(builder: ((context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        color: lightBlue,
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Center(
                    child: Text(
                  'Smart Wallet',
                  style: TextStyle(
                      fontSize: 32,
                      color: hardBlue,
                      fontWeight: FontWeight.bold),
                ))),
            Expanded(flex: 4, child: Image.asset('images/empty_wallet.png')),
          ],
        ),
      ),
    );
  }
}
