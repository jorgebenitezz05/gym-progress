import 'package:flutter/material.dart';

import 'exercise_list_screen.dart';
import 'routine_list_screen.dart';
import 'workout_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void abrirPantalla(BuildContext context, Widget pantalla) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pantalla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymProgress'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fitness_center,
              size: 90,
            ),
            const SizedBox(height: 24),
            const Text(
              'Bienvenido a GymProgress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Gestiona tus ejercicios, rutinas y entrenamientos.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  abrirPantalla(
                    context,
                    const ExerciseListScreen(),
                  );
                },
                icon: const Icon(Icons.fitness_center),
                label: const Text('Ejercicios'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  abrirPantalla(
                    context,
                    const RoutineListScreen(),
                  );
                },
                icon: const Icon(Icons.list_alt),
                label: const Text('Rutinas'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  abrirPantalla(
                    context,
                    const WorkoutListScreen(),
                  );
                },
                icon: const Icon(Icons.event_note),
                label: const Text('Entrenamientos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}