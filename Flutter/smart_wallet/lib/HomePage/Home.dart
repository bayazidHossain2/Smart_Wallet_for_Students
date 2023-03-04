import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_wallet/common.dart';

import '../Database/db.dart';
import '../Models/Estimate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> upperText = [
    'SPAND',
    'DEPOSIT',
    'SAVE',
  ];
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


  int totalAmount = 0;
  List<int> amounts = [];

  Widget buildDetails(String text) {
    return GestureDetector(
      onTap: () {
        print('TAP');
        setState(() {
          _descriptionController.text = text;
        });
      },
      onLongPress: () {
        print('Long pressed');
      },
      child: Card(
        color: lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(text),
        ),
      ),
    );
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
              upperText[index],
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

  Widget buildMoneyButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print(text + ' clicked');
          amounts.add(int.parse(text));
          totalAmount = totalAmount + int.parse(text);
          _amountController.text = totalAmount.toString();
        },
        child: Card(
          color: lightBlue,
          margin: EdgeInsets.all(5),
          child: Center(
              child: Text(
            text + ' /-',
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
                fontWeight: FontWeight.w800),
          )),
        ),
      ),
    );
  }

  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              // onChanged: (value) {
              //   setState(() {
              //     valueText = value;
              //   });
              // },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
  // String codeDialog;
  // String valueText;


  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add Details'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              TextField(
                
              ),
              

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
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
                    child: TextField(
                      controller: _amountController,
                      style: TextStyle(
                        fontSize: displayWidth * upperTextRatio,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        filled: true,
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
              child: TextField(
                controller: _descriptionController,
                style: TextStyle(
                  fontSize: displayWidth * upperTextRatio,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Description',
                  filled: true,
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
                    padding: const EdgeInsets.all(10.0),
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
                    if (_amountController.text.isNotEmpty) {
                      setState(() {
                        final estimate = Estimate(
                          type: upperText[index],
                          time: DateTime.now(),
                          amount: totalAmount,
                          description: _descriptionController.text,
                          market_id: 0,
                        );
                        final res =
                            WalletDatabase.instance.createEstimate(estimate);
                        print('Inserted restlt is : ------' + res.toString());
                      });
                      _amountController.clear();
                      _descriptionController.clear();
                      totalAmount = 0;
                      amounts.clear();
                    }
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'ADD',
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                    ),
                    buildDetails('গাড়ি ভাড়া'),
                    buildDetails('চা নাস্তা'),
                    buildDetails('অন্যান্য'),
                    buildDetails('Test text 1'),
                    buildDetails('Test text 2'),
                    buildDetails('Test text 3'),
                  ],
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
}
