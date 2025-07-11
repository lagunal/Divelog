import 'package:flutter/material.dart';
import 'package:flutter_divelog_test/dives_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiveLog',
      home: DivesScreen(),
    );
  }
}