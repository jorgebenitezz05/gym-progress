import 'package:flutter/material.dart';

import '../models/routine.dart';
import '../models/routine_exercise.dart';
import '../services/routine_exercise_service.dart';
import 'add_exercise_to_routine_screen.dart';

class RoutineDetailScreen extends StatefulWidget {
  final Routine routine;

  const RoutineDetailScreen({
    super.key,
    required this.routine,
  });

  @override
  State<RoutineDetailScreen> createState() => _RoutineDetailScreenState();
}

class _RoutineDetailScreenState extends State<RoutineDetailScreen> {
  final RoutineExerciseService routineExerciseService =
      RoutineExerciseService();

  late Future<List<RoutineExercise>> ejerciciosRutinaFuture;

  @override
  void initState() {
    super.initState();
    ejerciciosRutinaFuture = routineExerciseService.obtenerEjerciciosDeRutina(
      widget.routine.id,
    );
  }

  void recargarEjerciciosDeRutina() {
    setState(() {
      ejerciciosRutinaFuture = routineExerciseService.obtenerEjerciciosDeRutina(
        widget.routine.id,
      );
    });
  }

  Future<void> abrirPantallaAnadirEjercicio() async {
    final ejercicioAnadido = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseToRoutineScreen(
          routine: widget.routine,
        ),
      ),
    );

    if (ejercicioAnadido == true) {
      recargarEjerciciosDeRutina();
    }
  }

  String obtenerTextoDescanso(int? segundos) {
    if (segundos == null) {
      return 'Sin descanso definido';
    }

    return '$segundos segundos de descanso';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: recargarEjerciciosDeRutina,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirPantallaAnadirEjercicio,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<RoutineExercise>>(
        future: ejerciciosRutinaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No se pudieron cargar los ejercicios de la rutina',
                textAlign: TextAlign.center,
              ),
            );
          }

          final ejercicios = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                widget.routine.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.routine.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(widget.routine.description),
              ],
              const SizedBox(height: 24),
              const Text(
                'Ejercicios de la rutina',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (ejercicios.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Esta rutina todavía no tiene ejercicios',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...ejercicios.map((ejercicioRutina) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          ejercicioRutina.exerciseOrder.toString(),
                        ),
                      ),
                      title: Text(
                        ejercicioRutina.exerciseName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${ejercicioRutina.muscleGroup}\n'
                        '${ejercicioRutina.targetSets} series x '
                        '${ejercicioRutina.targetRepetitions} reps\n'
                        '${obtenerTextoDescanso(ejercicioRutina.restSeconds)}',
                      ),
                      isThreeLine: true,
                    ),
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}