import 'package:flutter/material.dart';

import '../models/workout_session.dart';
import '../services/workout_service.dart';
import 'create_workout_screen.dart';
import 'workout_detail_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  final WorkoutService workoutService = WorkoutService();

  late Future<List<WorkoutSession>> entrenamientosFuture;

  @override
  void initState() {
    super.initState();
    entrenamientosFuture = workoutService.obtenerEntrenamientos();
  }

  void recargarEntrenamientos() {
    setState(() {
      entrenamientosFuture = workoutService.obtenerEntrenamientos();
    });
  }

  Future<void> abrirPantallaCrearEntrenamiento() async {
    final entrenamientoCreado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateWorkoutScreen(),
      ),
    );

    if (entrenamientoCreado == true) {
      recargarEntrenamientos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis entrenamientos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: recargarEntrenamientos,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirPantallaCrearEntrenamiento,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<WorkoutSession>>(
        future: entrenamientosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No se pudieron cargar los entrenamientos',
                textAlign: TextAlign.center,
              ),
            );
          }

          final entrenamientos = snapshot.data ?? [];

          if (entrenamientos.isEmpty) {
            return const Center(
              child: Text(
                'Todavía no hay entrenamientos registrados',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entrenamientos.length,
            itemBuilder: (context, index) {
              final entrenamiento = entrenamientos[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailScreen(
                          workoutSession: entrenamiento,
                        ),
                      ),
                    );
                  },
                  leading: const Icon(Icons.event_note),
                  title: Text(
                    entrenamiento.routineName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${entrenamiento.workoutDate}\n${entrenamiento.notes}',
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
