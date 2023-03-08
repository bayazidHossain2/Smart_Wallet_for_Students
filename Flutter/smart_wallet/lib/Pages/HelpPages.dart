import 'package:flutter/material.dart';
import 'package:smart_wallet/common.dart';

class HelpPages extends StatelessWidget {
  
  const HelpPages({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Wallet Help'),
      ),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBoldText('নতুন Market কিভাবে যুক্ত করবো?'),
          buildText('শুরুতে Default নামে একটা Market যুক্ত থাকবে। Market অপশনে গেলে দেখা যাবে কোনটা এখন Active আছে। ডান পাশের নিচের দিকে Plus Button এ চাপ দিলেই Market এর নাম সেট করার অপশন আসবে। এর পর Save Button এ চাপ দিলেই ঐ নামে নতুন একটা Market তৈরী হয়ে যাবে এবং নতুন Market টি Active থাকবে।'),
          buildBoldText('Market এ হিসাব কিভাবে যুক্ত করবো?'),
          buildText('Home পেজ থেকে প্রথমেই কি ধরনের হিসাব যুক্ত করতে চাচ্ছি তা সেট করে নিবো। হিসাবের ধরন সেট করার সাথে সাথে রঙ ও পরিবর্তন হতে থাকবে। টাকার পরিমান ও বিবরন যুক্ত করে Add Button এ চাপ দিলেই হিসাবটি যুক্ত হয়ে যাবে।'),
          buildBoldText('টাকা কিভাবে দেখবো?'),
          buildText('ডান পাশের উপরের দিকে Balance লিখার উপর চাপ দিলে বর্তমান টাকার পরিমান সহ মোট খরচ, মোট জমা সব হিসাব দেখা যাবে। আবার ঐ একই স্থানে চাপ দিলে সকল টাকার পরিমান hide হয়ে যাবে।'),
          buildBoldText('টাকার পরিমান কিভাবে লিখবো?'),
          buildText('দুইভাবে যুক্ত করা যায়। \n\t(১) ডিভাইস এর কিবোর্ড ব্যাবহার করে।\n\t(২) প্রদত্ত নোটের পরিমান এর মাধ্যমে। টাকর পরিমানের উপর চাপ দিলেই বর্তমান টাকার সাথে ঐ পরিমান টাকা যুক্ত হয়ে যাবে। আবার undo button এ চাপ দেওয়ার মাধ্যমে যুক্ত টাকা উল্টা(সাবার শেষে যেটা এসেছে ঐটা আগে যাবে) ক্রমে উঠিয়ে নেওয়া যাবে।'),
          buildBoldText('হিসাবে বর্ননা কিভাবে যুক্ত করবো?'),
          buildText('দুইভাবে যুক্ত করা যায়। \n\t(১) ডিভাইস এর কিবোর্ড ব্যাবহার করে।\n\t(২) পূর্বে যুক্ত কৃত বর্ননা তে চাপ দিয়ে।'),
          buildBoldText('বর্ননা কিভাবে যুক্ত করবো?'),
          buildText('Home Page এ Plus Button এ চাপ দিলে বর্ননা যুক্ত করার অশন আসবে। সেখানে ছোট বর্ননা ও বড় বর্ননার জন্য অপশন থাকবে। বড় বর্ননা না দিলে কোন সমস্যা হবে না। এই বর্ননা টা কতটা গুরুত্বপুর্ন তা সেট করে সেভ করলেই হবে।'),
          buildBoldText('বর্ননা Edit করবো কিভাবে?'),
          buildText('বর্ননার উপর চাপ দিয়ে রাখলে Edit অপশন চলে আসবে। এখন থেকে পরিবর্তন করা যাবে।'),
          buildBoldText('বর্ননা Delete করবো কিভাবে?'),
          buildText('বর্ননার উপর চাপ দিয়ে রাখলে Edit চলে আসবে। এখন থেকে Delete Button এ চাপ দিলে বর্ননাটি মুছে যাবে।'),
          buildBoldText('হিসাব Delete করবো কিভাবে?'),
          buildText('হিসাব এর উপর চাপ দিয়ে রাখলে Delete এর নিশ্চয়তা চাবে। এখন থেকে I am sure Button এ চাপ দিলে হিসাবটি মুছে যাবে।'),
          buildBoldText('Market Active করবো কিভাবে?'),
          buildText('Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Make Active Button এ চাপ দিলে Active হয়ে যাবে।'),
          buildBoldText('Market Delete করবো কিভাবে?'),
          buildText('Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Delete Button এ চাপ দিলে Market টি মুছে যাবে।'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('images/home_spand.png'),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('images/market.png'),
                )),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('images/all_market.png'),
                )),
              ],
            ),
          ),
          Container(
            height: 2,
            color: blue,
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          ),
          buildBoldText('Up Coming'),
          buildText('User Page এ login করার মাধ্যমে সকল তথ্য অনলাইনে জমা রাখা যাবে। এবং পরে ব্যাক-আপ পাওয়া যাবে। এবং একজন ব্যাবহার কারী নির্দিষ্ট Market অন্য এক বা একাধিক ব্যাবহার কারির সাথে শেয়ার করেতে পারবে'),
          buildBoldText('\t\tBack UP'),
          buildBoldText('\t\tSharing'),
        ],
      ),),
    );
  }
  Widget buildText(String text){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text,),
    );
  }
  Widget buildBoldText(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,style: boldText,),
    );
  }
}
