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

final headingTextDesing = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w500,
  color: Colors.black
);
final boldText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black
);

