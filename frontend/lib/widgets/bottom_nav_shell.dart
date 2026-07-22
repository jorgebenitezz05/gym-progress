import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/routine_list_screen.dart';
import '../screens/workout_list_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/profile_screen.dart';

class BottomNavShell extends StatefulWidget {
  const BottomNavShell({super.key});

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    RoutineListScreen(),
    WorkoutListScreen(),
    StatsScreen(),
    ProfileScreen(),
  ];

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Inicio'),
    NavigationDestination(icon: Icon(Icons.fitness_center_rounded), label: 'Rutinas'),
    NavigationDestination(icon: Icon(Icons.sports_gymnastics_rounded), label: 'Entrenos'),
    NavigationDestination(icon: Icon(Icons.bar_chart_rounded), label: 'Estadísticas'),
    NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: const Color(0xFF22C55E).withValues(alpha: 46),
              height: 68,
              labelTextStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            child: NavigationBar(
              backgroundColor: const Color(0xFF181818),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() => _selectedIndex = index),
              destinations: _destinations,
            ),
          ),
        ),
      ),
    );
  }
}
