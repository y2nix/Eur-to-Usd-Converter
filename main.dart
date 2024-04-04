import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(CurrencyExchangeApp());
}

class CurrencyExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
