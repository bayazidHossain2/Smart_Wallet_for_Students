import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage/HomePage.dart';

final Color hardBlue = Colors.teal.shade700;
final Color blue = Colors.teal;
final Color lightBlue = Colors.teal.shade100;
final Color red = Colors.red;
final Color lightRed = Colors.red.shade100;
final Color yellow = Colors.yellow;
final Color lightYellow = Colors.yellow.shade100;
final Color green = Colors.green;
final Color lightGreen = Colors.green.shade100;
final Color white = Colors.white;
final Color violate = Colors.purple;
final Color lightViolate = Colors.purple.shade100;

final languageIndexText = 'smartWalletLanguageIndex';


final roundBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: blue,
  ),
  borderRadius: BorderRadius.circular(20),
);
final squareBorder = OutlineInputBorder(
  borderSide: BorderSide(
    width: 2,
    color: blue,
  ),
);
int pageIndex = 0;
int? currentMarketId = -1;
bool isLogin = false;
bool isRegister = false;

List<String> upperText = [
  'খরচ',
  'জমা',
  'সঞ্চয়',
  'SPEND',
  'DEPOSIT',
  'SAVE',
];

final headingTextDesing =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black);
final boldText =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);

final List<String> addMarketHeaderS = ['নতুন Market কিভাবে যুক্ত করবো?','How to create new Market?'];
final addMarketDescS =
    ['শুরুতে Default নামে একটা Market যুক্ত থাকবে। Market অপশনে গেলে দেখা যাবে কোনটা এখন Active আছে। ডান পাশের নিচের দিকে Plus Button এ চাপ দিলেই Market এর নাম সেট করার অপশন আসবে। এর পর Save Button এ চাপ দিলেই ঐ নামে নতুন একটা Market তৈরী হয়ে যাবে এবং নতুন Market টি Active থাকবে।',
    'First there are \'Default\' market. From market option we can see which one is active now. By pressing \'plus button (+)\' from right down corner there comes a dialog box for getting Market Name. After putting Name by pressing save button new Market will create and this market will be active market.'];
final addEstimateHeader = 'Market এ হিসাব কিভাবে যুক্ত করবো?';
final addEstimateDesc =
    'Home পেজ থেকে প্রথমেই কি ধরনের হিসাব যুক্ত করতে চাচ্ছি তা সেট করে নিবো। হিসাবের ধরন সেট করার সাথে সাথে রঙ ও পরিবর্তন হতে থাকবে। টাকার পরিমান ও বিবরন যুক্ত করে Add Button এ চাপ দিলেই হিসাবটি যুক্ত হয়ে যাবে।';
final showBalanceHeader = 'টাকা কিভাবে দেখবো?';
final showBalanceDesc =
    'ডান পাশের উপরের দিকে Balance লিখার উপর চাপ দিলে বর্তমান টাকার পরিমান সহ মোট খরচ, মোট জমা সব হিসাব দেখা যাবে। আবার ঐ একই স্থানে চাপ দিলে সকল টাকার পরিমান hide হয়ে যাবে।';
final writeBalanceHeader = 'টাকার পরিমান কিভাবে লিখবো?';
final writeBalanceDesc =
    'দুইভাবে যুক্ত করা যায়। \n\t(১) ডিভাইস এর কিবোর্ড ব্যাবহার করে।\n\t(২) প্রদত্ত নোটের পরিমান এর মাধ্যমে। টাকর পরিমানের উপর চাপ দিলেই বর্তমান টাকার সাথে ঐ পরিমান টাকা যুক্ত হয়ে যাবে। আবার undo button এ চাপ দেওয়ার মাধ্যমে যুক্ত টাকা উল্টা(সাবার শেষে যেটা এসেছে ঐটা আগে যাবে) ক্রমে উঠিয়ে নেওয়া যাবে।';
final writeDetailsHeader = 'হিসাবে বর্ননা কিভাবে যুক্ত করবো?';
final writeDetailsDesc =
    'দুইভাবে যুক্ত করা যায়। \n\t(১) ডিভাইস এর কিবোর্ড ব্যাবহার করে।\n\t(২) পূর্বে যুক্ত কৃত বর্ননা তে চাপ দিয়ে।';
final addDetailsHeader = 'বর্ননা কিভাবে যুক্ত করবো?';
final addDetailsDesc =
    'Home Page এ Plus Button এ চাপ দিলে বর্ননা যুক্ত করার অশন আসবে। সেখানে ছোট বর্ননা ও বড় বর্ননার জন্য অপশন থাকবে। বড় বর্ননা না দিলে কোন সমস্যা হবে না। এই বর্ননা টা কতটা গুরুত্বপুর্ন তা সেট করে সেভ করলেই হবে।';
final editDetailsHeader = 'বর্ননা Edit করবো কিভাবে?';
final editDetailsDesc =
    'বর্ননার উপর চাপ দিয়ে রাখলে Edit অপশন চলে আসবে। এখন থেকে পরিবর্তন করা যাবে।';
final deleteDetailsHeader = 'বর্ননা Delete করবো কিভাবে?';
final deleteDetailsDesc = 'বর্ননার উপর চাপ দিয়ে রাখলে Edit চলে আসবে। এখন থেকে Delete Button এ চাপ দিলে বর্ননাটি মুছে যাবে।';
final deleteEstimationHeader = 'হিসাব Delete করবো কিভাবে?';
final deleteEstimationDesc = 'হিসাব এর উপর চাপ দিয়ে রাখলে Delete এর নিশ্চয়তা চাবে। এখন থেকে I am sure Button এ চাপ দিলে হিসাবটি মুছে যাবে।';
final activeMarketHeader = 'Market Active করবো কিভাবে?';
final activeMarketDesc = 'Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Make Active Button এ চাপ দিলে Active হয়ে যাবে।';
final deleteMarketHeader = 'Market Delete করবো কিভাবে?';
final deleteMarketDesc = 'Market Page এ গিয়ে ডানপাশে উপরের দিকে See All Button এ চাপ দিলে All Market Page এ চলে যাবে। সেখানে নির্ধারিত Market এর Delete Button এ চাপ দিলে Market টি মুছে যাবে।';


String languageType = 'bangla';
int languageIndex = 0;
String appBarBalanceText = (languageIndex ==0)?'টাকা দেখুন':'Balance';

String getBangla(String str){
  String bangla='';
  for(int i=0;i<str.length;i++){
    switch(str[i]){
      case '0': 
        bangla = bangla + '০';
        break;
      case '1':
        bangla = bangla + '১';
        break;
      case '2':
        bangla = bangla + '২';
        break;
      case '3':
        bangla = bangla + '৩';
        break;
      case '4':
        bangla = bangla + '৪';
        break;
      case '5':
        bangla = bangla + '৫';
        break;
      case '6':
        bangla = bangla + '৬';
        break;
      case '7':
        bangla = bangla + '৭';
        break;
      case '8':
        bangla = bangla + '৮';
        break;
      case '9':
        bangla = bangla + '৯';
        break;
      default:
        bangla = bangla + str[i];
    }
  }
  return bangla;
}

String getEnglish(String str){
  String english='';
  for(int i=0;i<str.length;i++){
    switch(str[i]){
      case '০': 
        english = english + '0';
        break;
      case '১': 
        english = english + '1';
        break;
      case '২': 
        english = english + '2';
        break;
      case '৩': 
        english = english + '3';
        break;
      case '৪': 
        english = english + '4';
        break;
      case '৫': 
        english = english + '5';
        break;
      case '৬': 
        english = english + '6';
        break;
      case '৭': 
        english = english + '7';
        break;
      case '৮': 
        english = english + '8';
        break;
      case '৯': 
        english = english + '9';
        break;
      default:
        english = english + str[i];
    }
  }
  return english;
}

void refreshPage(BuildContext context ){
  Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => HomePage())));
}

