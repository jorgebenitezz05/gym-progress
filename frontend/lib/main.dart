import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const GymProgressApp());
}

class GymProgressApp extends StatelessWidget {
  const GymProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymProgress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}