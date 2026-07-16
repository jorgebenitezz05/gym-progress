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

      // Tema general de la aplicación
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16A34A),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F7FA),

        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),

        cardTheme: CardThemeData(
          elevation: 6,
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}