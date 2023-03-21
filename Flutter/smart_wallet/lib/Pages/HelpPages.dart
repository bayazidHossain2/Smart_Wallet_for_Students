import 'package:flutter/material.dart';
import 'package:smart_wallet/common.dart';

class HelpPages extends StatefulWidget {
  const HelpPages({super.key});

  @override
  State<HelpPages> createState() => _HelpPageStates();
}

class _HelpPageStates extends State<HelpPages> {
  bool isBangla = true;
  List<String> language = ['Bn', 'En'];

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
                      'Change Language : ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Switch(
                        //thumbIcon: thumbIcon,
                        value: isBangla,
                        onChanged: ((value) {
                          setState(() {
                            isBangla = value;
                          });
                        }))
                  ],
                ),
              ),
            ),
            buildBoldText(addMarketHeader),
            buildText(addMarketDesc),
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
            buildBoldText('বর্ননা Delete করবো কিভাবে?'),
            buildText(
                'বর্ননার উপর চাপ দিয়ে রাখলে Edit চলে আসবে। এখন থেকে Delete Button এ চাপ দিলে বর্ননাটি মুছে যাবে।'),
            buildBoldText('হিসাব Delete করবো কিভাবে?'),
            buildText(
                'হিসাব এর উপর চাপ দিয়ে রাখলে Delete এর নিশ্চয়তা চাবে। এখন থেকে I am sure Button এ চাপ দিলে হিসাবটি মুছে যাবে।'),
            buildBoldText('Market Active করবো কিভাবে?'),
            buildText(
                'Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Make Active Button এ চাপ দিলে Active হয়ে যাবে।'),
            buildBoldText('Market Delete করবো কিভাবে?'),
            buildText(
                'Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Delete Button এ চাপ দিলে Market টি মুছে যাবে।'),
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
