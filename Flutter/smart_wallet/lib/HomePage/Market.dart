
import 'package:flutter/material.dart';

class Market1 extends StatefulWidget {
  const Market1({super.key});

  @override
  State<Market1> createState() => _MarketState();
}

class _MarketState extends State<Market1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text('Market Page.'),)),
    );
  }
}