import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_wallet/Database/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Models/Estimate.dart';
import 'package:smart_wallet/Pages/AllMarketPages.dart';
import 'package:smart_wallet/common.dart';
import '../Models/Market.dart';
import 'HomePage.dart';

class Market1 extends StatefulWidget {
  const Market1({super.key});

  @override
  State<Market1> createState() => _MarketState();
}

class _MarketState extends State<Market1> {
  bool isMarketFind = false;
  bool isLoading = false;
  Market? currentMarket;
  List<Estimate> estimates = [];
  final _marketNameController = TextEditingController();
  int? _currentMarketId;
  Map<String, Color> colors = {
    'SPEND': lightRed,
    'DEPOSIT': lightViolate,
    'SAVE': lightGreen,
    'খরচ': lightRed,
    'জমা': lightViolate,
    'সঞ্চয়': lightGreen,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarketId();
  }

  void getMarketId() async {
    setState(() {
      isMarketFind = false;
    });
    final prefs = await SharedPreferences.getInstance();
    this._currentMarketId = prefs.getInt(MarketFields.currentMarket);
    if (_currentMarketId == null) {
      print("Null Market id----------");
      List<Market> allMarketList =
          await WalletDatabase.instance.readAllMarket();
      print('Total market find : ' + allMarketList.length.toString());
      if (allMarketList.isEmpty) {
        final market = Market(
          name: 'Default',
          creatingTime: DateTime.now(),
        );
        this.currentMarket = await WalletDatabase.instance.createMarket(market);
      } else {
        this.currentMarket = allMarketList[0];
      }
      _currentMarketId = currentMarket!.getId();
      await prefs.setInt(MarketFields.currentMarket, _currentMarketId ?? 0);
      // print('Market name is : '+market.name);
      print(
          'market is : ' + prefs.getInt(MarketFields.currentMarket).toString());
    } else {
      print('find market id is : ' + _currentMarketId.toString());
      this.currentMarket =
          await WalletDatabase.instance.readMarket(_currentMarketId!);
    }
    setState(() {
      isMarketFind = true;
    });
    loadEstimate();
  }

  void loadEstimate() async {
    setState(() {
      isLoading = true;
      print('--------------Est reading starr with id : ' +
          _currentMarketId.toString());
    });

    this.estimates = await WalletDatabase.instance
        .readAllEstimateByMarketId(_currentMarketId ?? 0);

    setState(() {
      isLoading = false;
      print('est reading finish');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isMarketFind
            ? isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            color: lightBlue,
                            margin: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                currentMarket!.name,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AllMarketPage())));
                            }),
                            child: Text((languageIndex==0)?'সব দেখুন':'See All'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Expanded(
                        child: buildEstimates(),
                      ),
                    ],
                  )
            : CircularProgressIndicator(),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            _showMyDialog();
          }),
          child: Icon(Icons.add),
        ));
  }

  Widget buildEstimates() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: estimates.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final estimate = estimates[index];
          return GestureDetector(
            onTap: () async {
              // await Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => NoteDetailPage(noteId: note.id!),
              // ));

              //refreshNotes();
            },
            onLongPress: () {
              _showDeleteDialog(estimate.id ?? 0);
            },
            //child: Text('Name is : '+name),
            child: Card(
              color: colors[estimate.type],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      estimate.description,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Text(estimate.time.toString().substring(0, 19)),
                    Text('Type : ' + estimate.type),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        Text('Amount : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Text(
                          estimate.amount.toString() + ' ৳',
                          style: TextStyle(
                              fontSize: 18,
                              color: red,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Creating Market'),
          content: TextField(
            decoration: InputDecoration(
              label: Text('Market Name'),
              focusedBorder: squareBorder,
              enabledBorder: roundBorder,
            ),
            controller: _marketNameController,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Calcle'),
              onPressed: () {
                _marketNameController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                if (_marketNameController.text.isNotEmpty) {
                  final time = DateTime.now();
                  final market = Market(
                      name: _marketNameController.text, creatingTime: time);
                  this.currentMarket =
                      await WalletDatabase.instance.createMarket(market);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt(
                      MarketFields.currentMarket, currentMarket!.id ?? 0);
                  print('Market inserted  restlt is : ------' +
                      currentMarket!.name);
                  _marketNameController.clear();
                  estimates.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteDialog(int estimateId) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Estimate Deleting'),
          content: Text('Are you sure to delete this estimate.'),
          actions: [
            ElevatedButton(
                onPressed: (() {
                  WalletDatabase.instance.deleteEstimate(estimateId);
                  Navigator.of(context).popUntil((route) => false);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => HomePage())));
                }),
                child: Text(
                  'I am Sure',
                )),
            ElevatedButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: Text('Cancle')),
          ],
        );
      },
    );
  }
}
