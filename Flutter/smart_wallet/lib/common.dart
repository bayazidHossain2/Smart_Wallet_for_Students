import 'package:flutter/material.dart';

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
String appBarBalanceText = 'Balance';
List<String> upperText = [
  'SPEND',
  'DEPOSIT',
  'SAVE',
];

final headingTextDesing =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black);
final boldText =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);


final addMarketHeader = 'নতুন Market কিভাবে যুক্ত করবো?';
final addMarketDesc =
    'শুরুতে Default নামে একটা Market যুক্ত থাকবে। Market অপশনে গেলে দেখা যাবে কোনটা এখন Active আছে। ডান পাশের নিচের দিকে Plus Button এ চাপ দিলেই Market এর নাম সেট করার অপশন আসবে। এর পর Save Button এ চাপ দিলেই ঐ নামে নতুন একটা Market তৈরী হয়ে যাবে এবং নতুন Market টি Active থাকবে।';
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
