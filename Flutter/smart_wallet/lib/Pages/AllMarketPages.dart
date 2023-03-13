
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Database/db.dart';
import 'package:smart_wallet/HomePage/HomePage.dart';
import 'package:smart_wallet/common.dart';

import '../Models/Market.dart';

class AllMarketPage extends StatefulWidget {
  const AllMarketPage({super.key});

  @override
  State<AllMarketPage> createState() => _AllMarketPageState();
}

class _AllMarketPageState extends State<AllMarketPage> {
  List<Market> marketList = [];
  List<List<int>> balanceList = [[]];
  bool isMarketLoading = false;
  bool isBalanceLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllMarkets();
  }

  loadAllMarkets() async {
    setState(() {
      isMarketLoading = true;
    });
    marketList = await WalletDatabase.instance.readAllMarket();

    setState(() {
      isMarketLoading = false;
      isBalanceLoading = true;
    });

    loadAllBalance();
  }

  void loadAllBalance() async {
    balanceList.clear();
    for (int i = 0; i < marketList.length; i++) {
      print('----calling $i th market' + marketList[i].id.toString());

      balanceList.add(
        await WalletDatabase.instance.readBalance(marketList[i].id ?? 1),
      );
      print('Read success with balance size : ' +
          balanceList[balanceList.length - 1].length.toString());
    }
    setState(() {
      isBalanceLoading = false;
    });
  }

  void makeCurrentMarket(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(MarketFields.currentMarket, id);
  }

  void deleteMarket(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final activeId = await prefs.getInt(MarketFields.currentMarket);
    if (activeId == id) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Activated Market can\'t be delete',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: lightRed,
      ));
    } else {
      _showMyDialog();
      WalletDatabase.instance.deleteMarket(id);
      print('Delete success');
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Markets'),
      ),
      body: isMarketLoading
          ? CircularProgressIndicator()
          : marketList.isEmpty
              ? Text('No Market availeable.')
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildMarketView(),
                  ),
                ),
    );
  }

  List<Widget> buildMarketView() {
    List<Widget> views = [];

    for (int i = 0; i < marketList.length; i++) {
      views.add(Card(
          color: lightBlue,
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        marketList[i].name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                      Text(marketList[i]
                          .creatingTime
                          .toString()
                          .substring(0, 19)),
                      Wrap(
                        children: [
                          ElevatedButton(
                            onPressed: (() {
                              makeCurrentMarket(marketList[i].id ?? 0);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: lightGreen,
                                  content: Text(
                                    marketList[i].name + ' is Activated.',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                              Navigator.of(context).popUntil((route) => false);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => HomePage())));
                            }),
                            child: Text('Make Active'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: (() {
                              setState(() {
                                deleteMarket(marketList[i].id ?? 0);
                              });
                            }),
                            child: Text('Delete'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                    child: isBalanceLoading
                        ? CircularProgressIndicator()
                        : balanceList[i].length < 4
                            ? Text('Balance length : ' +
                                balanceList[i].length.toString())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Spend : ' +
                                      balanceList[i][1].toString() +
                                      ' ৳'),
                                  Text('Deposit : ' +
                                      balanceList[i][2].toString() +
                                      ' ৳'),
                                  Text('Save : ' +
                                      balanceList[i][3].toString() +
                                      ' ৳'),
                                  Text('Balance : ' +
                                      balanceList[i][0].toString() +
                                      ' ৳', style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ))
              ],
            ),
          )));
    }

    return views;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text('Deleting'),
          ]),
          content: Text(
              'Wait few seconds to delete Market and estimates related to the market'),
        );
      },
    );
  }
}
