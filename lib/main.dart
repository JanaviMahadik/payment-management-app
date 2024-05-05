//main.dart
import 'package:flutter/material.dart';
import 'appbar_screen.dart';

void main() {
  runApp(YourApp());
}

class YourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppbarScreen(),
    );
  }
}
