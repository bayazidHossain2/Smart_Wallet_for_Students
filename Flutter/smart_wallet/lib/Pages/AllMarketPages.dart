

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Database/db.dart';
import 'package:smart_wallet/common.dart';

import '../Models/Market.dart';

class AllMarketPage extends StatefulWidget {
  const AllMarketPage({super.key});

  @override
  State<AllMarketPage> createState() => _AllMarketPageState();
}

class _AllMarketPageState extends State<AllMarketPage> {

  List<Market> marketList = [];
  bool isMarketLoading = false;

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
    });
  }

  void makeCurrentMarket(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(MarketFields.currentMarket, id);
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
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildMarketView(),
                  )
    );
  }

  List<Widget> buildMarketView(){
    List<Widget> views = [];
    for(int i=0;i<marketList.length;i++){
      views.add(
        Card(
          color: lightBlue,
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(  
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(marketList[i].name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                Text(marketList[i].creatingTime.toString().substring(0,19)),
                Wrap(
                  children: [
                    ElevatedButton(onPressed: (() {
                      makeCurrentMarket(marketList[i].id ?? 0);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: lightGreen,
                          content: Text(marketList[i].name+' is Activated.',style: TextStyle(color: Colors.black),),
                        )
                      );
                    }), child: Text('Make Active'),),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                    ElevatedButton(onPressed: (() {
                      
                    }), child: Text('Delete')),
                  ],
                )
              ],
            ),
          )
        )
      );
    }

    return views;
  }
}