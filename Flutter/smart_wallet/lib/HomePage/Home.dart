import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_wallet/Models/Details.dart';
import 'package:smart_wallet/Pages/HelpPages.dart';
import 'package:smart_wallet/common.dart';

import '../Database/db.dart';
import '../Models/Estimate.dart';
import '../Models/Market.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double displayHeight = 0.0;
  double displayWidth = 0.0;
  int index = 0;
  double upperTextRatio = 0.04;
  double fontSize = 0.0;
  List<Color?> upperTextBackground = [
    lightRed,
    lightViolate,
    lightGreen,
  ];
  List<Color?> upperTextColor = [
    red,
    violate,
    green,
  ];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shortDescriptionCotroller = TextEditingController();
  final _longDescriptionCotroller = TextEditingController();
  int importantCount = 1;

  int totalAmount = 0;
  List<int> amounts = [];

  List<Details> detailsList = [];
  List<Widget> detailsView = [];
  bool detailsIsLoading = false;
  int detailsUpdatingId = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  void loadDetails() async {
    setState(() {
      detailsIsLoading = true;
      print('--------------details reading starr');
    });

    this.detailsList = await WalletDatabase.instance.readAllDetails();

    setState(() {
      detailsIsLoading = false;
      print('details reading finish');
    });
  }

  

  Color? getBackgroundColor(int index) {
    if (this.index == index) {
      return lightBlue;
    } else {
      return upperTextBackground[index];
    }
  }

  Widget buildUpperDesing(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            this.index = index;
          });
        },
        child: Card(
          color: getBackgroundColor(index),
          margin: EdgeInsets.all(8),
          elevation: 5,
          child: Center(
            child: Text(
              upperText[index + (languageIndex * 3)],
              style: TextStyle(
                fontSize: min(displayWidth, (2 * displayHeight / 3).floor()) *
                    upperTextRatio,
                fontWeight: FontWeight.bold,
                color: upperTextColor[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetails(int index) {
    return GestureDetector(
      onTap: () {
        print('TAP');
        setState(() {
          _descriptionController.text = detailsList[index].long;
        });
      },
      onLongPress: () {
        print('Long pressed');
        detailsUpdatingId = detailsList[index].id ?? -1;
        _shortDescriptionCotroller.text = detailsList[index].short;
        _longDescriptionCotroller.text = detailsList[index].long;
        importantCount = detailsList[index].important;
        _showMyDialog();
        print('Id is found $detailsUpdatingId');
      },
      child: Card(
        color: lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(detailsList[index].short),
        ),
      ),
    );
  }

  Widget buildMoneyButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print(text + ' clicked');
          amounts.add(int.parse(text));
          totalAmount = totalAmount + int.parse(text);
          _amountController.text = (languageIndex == 0)?getBangla(totalAmount.toString()):totalAmount.toString();
        },
        child: Card(
          color: lightBlue,
          margin: EdgeInsets.all(5),
          child: Center(
            child: Text(
              ((languageIndex == 0) ? getBangla(text) : text) + ' ৳',
              style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    displayHeight = MediaQuery.of(context).size.height;
    displayWidth = MediaQuery.of(context).size.width;
    fontSize = displayWidth * upperTextRatio;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(6),
              color: lightBlue,
              child: Center(
                child: Row(
                  children: [
                    buildUpperDesing(0),
                    buildUpperDesing(1),
                    buildUpperDesing(2),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: displayHeight * 0.02,
          ),
          Expanded(
            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(6),
              color: upperTextBackground[index],
              child: Row(
                children: [
                  Expanded(
                    //flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        controller: _amountController,
                        style: TextStyle(
                          fontSize: displayWidth * upperTextRatio,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText:
                              (languageIndex == 0) ? 'টাকার পরিমাণ' : 'Amount',
                          filled: true,
                          focusedBorder: squareBorder,
                          enabledBorder: roundBorder,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (amounts.isNotEmpty) {
                        setState(() {
                          totalAmount = totalAmount - amounts.last;
                          _amountController.text = totalAmount.toString();
                          amounts.removeLast();
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.undo),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(6),
              color: upperTextBackground[index],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: _descriptionController,
                    style: TextStyle(
                      fontSize: displayWidth * upperTextRatio,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText:
                          (languageIndex == 0) ? 'খরচের বিবরন' : 'Description',
                      focusedBorder: squareBorder,
                      enabledBorder: roundBorder,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: (() {
                    setState(() {
                      _amountController.clear();
                      _descriptionController.clear();
                      totalAmount = 0;
                      amounts.clear();
                    });
                  }),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(lightBlue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.cancel,
                      color: red,
                    ),
                  ),
                ),
                SizedBox(
                  width: displayWidth * 0.02,
                ),
                ElevatedButton(
                  onPressed: (() {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (currentMarketId == null || currentMarketId == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: lightRed,
                          content: Text((languageIndex == 0)
                              ? 'কোন মার্কেট নির্বাচন করা হয়নাই।'
                              : 'No market is activated.')));
                    } else {
                      if (appBarBalanceText != 'Balance') {
                        print('Balance button clicked');
                        appBarBalanceText = 'Balance';
                        upperText[0] = 'খরচ';
                        upperText[1] = 'জমা';
                        upperText[2] = 'সঞ্চয়';
                        upperText[3] = 'SPEND';
                        upperText[4] = 'DEPOSIT';
                        upperText[5] = 'SAVE';
                      }
                      if (_amountController.text.isNotEmpty) {
                        bool isOk = true;
                        String str = (languageIndex == 0)?getEnglish(_amountController.text): _amountController.text;
                        print('>>>>>>>str is 1: $str');
                        for (int i = 0; i < str.length; i++) {
                          if (str[i] == '0' ||
                              str[i] == '1' ||
                              str[i] == '2' ||
                              str[i] == '3' ||
                              str[i] == '4' ||
                              str[i] == '5' ||
                              str[i] == '6' ||
                              str[i] == '7' ||
                              str[i] == '8' ||
                              str[i] == '9') {
                          } else {
                            isOk = false;
                            break;
                          }
                        }

                        if (isOk) {
                          setState(() {
                            final estimate = Estimate(
                              type: upperText[index],
                              time: DateTime.now(),
                              amount: int.parse(str),
                              description: _descriptionController.text,
                              market_id: currentMarketId ?? 0,
                            );
                            final res = WalletDatabase.instance
                                .createEstimate(estimate);
                            print(
                                'Inserted restlt is : ------' + res.toString());
                            print('insert to the market id is : ' +
                                currentMarketId.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: lightRed,
                              content: Text(
                                (languageIndex == 0)
                                    ? 'হিসাব যুক্ত সফল হয়েছে।'
                                    : 'Estimate inserted success.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ));
                          });
                          _amountController.clear();
                          _descriptionController.clear();
                          totalAmount = 0;
                          amounts.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: lightRed,
                              content: Text(
                                (languageIndex == 0)
                                    ? 'ভুল টাকার পরিমাণ। শুধুমাত্র সংখ্যা ব্যাবহার করুন।'
                                    : 'Invalid amount text. Use only digits.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: lightRed,
                            content: Text(
                              (languageIndex == 0)
                                  ? 'টাকার পরিমাণ বেতিত হিসাব যুক্ত করা যাবে না।'
                                  : 'Empty amount can not be added.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }
                    }
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      (languageIndex == 0) ? 'যুক্ত করুন' : 'ADD',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                ),
                SizedBox(
                  width: displayWidth * 0.02,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: detailsIsLoading
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: buildDetailsView(),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: null,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        buildMoneyButton('1'),
                        buildMoneyButton('2'),
                        buildMoneyButton('5'),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        buildMoneyButton('10'),
                        buildMoneyButton('20'),
                        buildMoneyButton('50'),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        buildMoneyButton('100'),
                        buildMoneyButton('500'),
                        buildMoneyButton('1000'),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildDetailsView() {
    detailsView.clear();
    detailsView.add(GestureDetector(
      onTap: () {
        print('Add details clicked');
        _showMyDialog();
      },
      child: Card(
        color: lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    ));

    for (int i = 0; i < detailsList.length; i++) {
      detailsView.add(buildDetails(i));
    }

    return detailsView;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: detailsUpdatingId == -1
              ? Text((languageIndex == 0)
                  ? 'বর্ননা তৈরী করুন'
                  : 'Creating Details')
              : Text((languageIndex == 0)
                  ? 'বর্ননা পরিবর্তন করুন'
                  : 'Updating Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    label: Text((languageIndex == 0)
                        ? 'ছোট বর্ননা যুক্ত করুন'
                        : 'Short Description'),
                    focusedBorder: squareBorder,
                    enabledBorder: roundBorder,
                  ),
                  controller: _shortDescriptionCotroller,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: Text((languageIndex == 0)
                        ? 'ঐচ্ছিক, বড় বর্ননা যুক্ত করুন'
                        : 'Optional Long Description'),
                    focusedBorder: squareBorder,
                    enabledBorder: roundBorder,
                  ),
                  controller: _longDescriptionCotroller,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: (() {
                        importantCount = importantCount + 1;
                        Navigator.of(context).pop();
                        _showMyDialog();
                      }),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(lightBlue),
                      ),
                      child: Icon(Icons.add, color: green),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(importantCount.toString()),
                    ),
                    TextButton(
                      onPressed: (() {
                        if (importantCount > 1) {
                          importantCount = importantCount - 1;
                          Navigator.of(context).pop();
                          _showMyDialog();
                        }
                      }),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(lightBlue),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            detailsUpdatingId == -1
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : ElevatedButton(
                    child: Text((languageIndex == 0) ? 'মুছুন' : 'Delete'),
                    onPressed: () {
                      _shortDescriptionCotroller.clear();
                      _longDescriptionCotroller.clear();
                      importantCount = 1;
                      WalletDatabase.instance.deleteDetails(detailsUpdatingId);
                      detailsUpdatingId = -1;
                      loadDetails();
                      Navigator.of(context).pop();
                    },
                  ),
            ElevatedButton(
              child: Text((languageIndex == 0) ? 'বাতিল' : 'Cancel'),
              onPressed: () {
                _shortDescriptionCotroller.clear();
                _longDescriptionCotroller.clear();
                importantCount = 1;
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text((languageIndex == 0) ? 'সংরক্ষণ করুন' : 'Save'),
              onPressed: () {
                if (_shortDescriptionCotroller.text.isNotEmpty) {
                  final details = Details(
                    short: _shortDescriptionCotroller.text,
                    long: _longDescriptionCotroller.text.isEmpty
                        ? _shortDescriptionCotroller.text
                        : _longDescriptionCotroller.text,
                    important: importantCount,
                  );
                  if (detailsUpdatingId >= 0) {
                    final res = WalletDatabase.instance
                        .updateDetails(details.copy(id: detailsUpdatingId));
                    print(
                        'Details Updated restlt is : ------' + res.toString());
                    detailsUpdatingId = -1;
                  } else {
                    final res = WalletDatabase.instance.createDetails(details);
                    print('Details inserted Inserted restlt is : ------' +
                        res.toString());
                  }
                  _amountController.clear();
                  _descriptionController.clear();
                  totalAmount = 0;
                  amounts.clear();

                  _shortDescriptionCotroller.clear();
                  _longDescriptionCotroller.clear();
                  importantCount = 1;
                  loadDetails();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
