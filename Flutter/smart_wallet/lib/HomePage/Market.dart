import 'package:flutter/material.dart';
import 'package:smart_wallet/Database/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Models/Estimate.dart';
import 'package:smart_wallet/common.dart';
import '../Models/Market.dart';

class Market1 extends StatefulWidget {
  const Market1({super.key});

  @override
  State<Market1> createState() => _MarketState();
}

class _MarketState extends State<Market1> {
  bool isLoading = false;
  Market? market;
  List<Estimate> estimates = [
  ];
  final _marketNameController = TextEditingController();
  int? _marketId;
  Map<String, Color> colors = {
    'SPAND': lightRed,
    'DEPOSIT': lightViolate,
    'SAVE': lightGreen,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getMarketId();
    refreshMarket();
  }

  // void getMarketId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   this._marketId = prefs.getInt(MarketFields.currentMarket);
  //   if (_marketId == null) {
  //     print("Null Market id");
  //     final market = Market(
  //       name: 'Default',
  //       creatingTime: DateTime.now(),
  //     );
  //     this.market = await WalletDatabase.instance.createMarket(market);
  //     await prefs.setInt(MarketFields.currentMarket, market.id ?? 0);
  //     //print('Market name is : '+market.name);
  //     //print('market is : '+prefs.getInt(MarketFields.currentMarket).toString());
  //   } else {
  //     //print('Id find from spr');
  //     this.market = await WalletDatabase.instance.readMarket(_marketId!);
  //   }
  // }
  void refreshMarket() async {
    setState(() {
      isLoading = true;
      print('--------------Est reading starr');
    });

    this.estimates = await WalletDatabase.instance.readAllEstimate();

    setState(() {
      isLoading = false;
      print('est reading finish');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _marketNameController,
              decoration: InputDecoration(
                label: Text('Market'),
                hintText: 'Market Name',
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: (() {
                if (_marketNameController.text.isNotEmpty) {
                  setState(() {
                    final market = Market(
                      name: _marketNameController.text,
                      creatingTime: DateTime.now(),
                    );
                    final res = WalletDatabase.instance.createMarket(market);
                    print('restlt is : ------' + res.toString());
                  });
                }
              }),
              child: Text('Create'),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: isLoading
                    ? CircularProgressIndicator()
                    : estimates.isNotEmpty
                        ? Column(
                            children: buildEstimate(),
                          )
                        : Text('market!.name')

                // isLoading
                //     ? CircularProgressIndicator()
                //     : estimates.length == 0
                //         ? Text('No Estimate found in database.')
                //         : Text('Not ')
                // : Column(
                //     children: buildEstimate(),
                //   ),
                )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: (() {}),
            child: Icon(Icons.add),
          )
    );
  }

  List<Widget> buildEstimate() {
    List<Widget> list = [];

    for (int i = 0; i < estimates.length; i++) {
      String details = estimates[i].description;
      String amount = estimates[i].amount.toString();
      String type = estimates[i].type.toString();
      String time = estimates[i].time.toString();
      list.add(
        Card(
          margin: EdgeInsets.all(4),
          color: colors[type],
          child: Column(
            children: [
              Text(time),
              Text(details),
              Text(amount),
            ],
          ),
        ),
      );
    }
    return list;
  }
}
