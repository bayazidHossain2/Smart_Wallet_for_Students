import 'package:digital_wallet/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPageStates();
}

class _HelpPageStates extends State<HelpPages> {
  bool isBangla = (languageIndex == 0)?true:false;
  List<String> language = ['Bn', 'En'];
  String languageStr = 'Change Language : (Bangla)';
  void setIndex() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(languageIndexText, languageIndex);
  }

  // final MaterialStateProperty<Text?> thumbText =
  //     MaterialStateProperty.resolveWith<Text?>(
  //   (Set<MaterialState> states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return const Text('En');
  //     }
  //     return const Text('Bn');
  //   },
  // );

  // final MaterialStateProperty<Icon?> thumbIcon =
  //     MaterialStateProperty.resolveWith<Icon?>(
  //   (Set<MaterialState> states) {
  //     // Thumb icon when the switch is selected.
  //     if (states.contains(MaterialState.selected)) {
  //       return const Icon(Icons.check);
  //     }
  //     return const Icon(Icons.close);
  //   },
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Wallet Help'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: lightYellow,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageStr,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Switch(
                        //thumbIcon: thumbIcon,
                        value: isBangla,
                        onChanged: ((value) {
                          setState(() {
                            isBangla = value;
                            if(isBangla){
                              languageStr = 'Change Language : (Bangla)';
                              languageIndex = 0;
                            }else{
                              languageStr = 'Change Language : (English)';
                              languageIndex = 1;
                            }
                            setIndex();
                          });
                        }))
                  ],
                ),
              ),
            ),
            buildBoldText(addMarketHeaderS[languageIndex]),
            buildText(addMarketDescS[languageIndex]),
            buildBoldText(addEstimateHeader),
            buildText(addEstimateDesc),
            buildBoldText(showBalanceHeader),
            buildText(showBalanceDesc),
            buildBoldText(writeBalanceHeader),
            buildText(writeBalanceDesc),
            buildBoldText(writeDetailsHeader),
            buildText(writeDetailsDesc),
            buildBoldText(addDetailsHeader),
            buildText(addDetailsDesc),
            buildBoldText(editDetailsHeader),
            buildText(editDetailsDesc),
            buildBoldText(deleteDetailsHeader),
            buildText(deleteDetailsDesc),
            buildBoldText(deleteEstimationHeader),
            buildText(deleteEstimationDesc),
            buildBoldText(activeMarketHeader),
            buildText(activeMarketDesc),
            buildBoldText(deleteMarketHeader),
            buildText(deleteMarketDesc),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('images/home_spand.png'),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('images/market.png'),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('images/all_market.png'),
                  )),
                ],
              ),
            ),
            Container(
              height: 2,
              color: blue,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            ),
            buildBoldText('Up Coming'),
            buildText(
                'User Page এ login করার মাধ্যমে সকল তথ্য অনলাইনে জমা রাখা যাবে। এবং পরে ব্যাক-আপ পাওয়া যাবে। এবং একজন ব্যাবহার কারী নির্দিষ্ট Market অন্য এক বা একাধিক ব্যাবহার কারির সাথে শেয়ার করেতে পারবে'),
            buildBoldText('\t\tBack UP'),
            buildBoldText('\t\tSharing'),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
      ),
    );
  }

  Widget buildBoldText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: boldText,
      ),
    );
  }
}
