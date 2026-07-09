import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../services/exercise_service.dart';

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  final ExerciseService exerciseService = ExerciseService();

  late Future<List<Exercise>> ejerciciosFuture;

  @override
  void initState() {
    super.initState();
    ejerciciosFuture = exerciseService.obtenerEjercicios();
  }

  void recargarEjercicios() {
    setState(() {
      ejerciciosFuture = exerciseService.obtenerEjercicios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis ejercicios'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: recargarEjercicios,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Exercise>>(
        future: ejerciciosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No se pudieron cargar los ejercicios',
                textAlign: TextAlign.center,
              ),
            );
          }

          final ejercicios = snapshot.data ?? [];

          if (ejercicios.isEmpty) {
            return const Center(
              child: Text(
                'Todavía no hay ejercicios creados',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ejercicios.length,
            itemBuilder: (context, index) {
              final ejercicio = ejercicios[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(
                    ejercicio.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${ejercicio.muscleGroup}\n${ejercicio.description}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}