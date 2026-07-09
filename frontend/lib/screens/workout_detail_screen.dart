import 'package:flutter/material.dart';

import '../models/workout_session.dart';
import '../models/workout_set.dart';
import '../services/workout_service.dart';
import 'add_workout_set_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutSession workoutSession;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutSession,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final WorkoutService workoutService = WorkoutService();

  late Future<List<WorkoutSet>> seriesFuture;

  @override
  void initState() {
    super.initState();

    seriesFuture = workoutService.obtenerSeriesDeEntrenamiento(
      widget.workoutSession.id,
    );
  }

  void recargarSeries() {
    setState(() {
      seriesFuture = workoutService.obtenerSeriesDeEntrenamiento(
        widget.workoutSession.id,
      );
    });
  }

  Future<void> abrirPantallaAnadirSerie() async {
    final serieCreada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkoutSetScreen(
          workoutSession: widget.workoutSession,
        ),
      ),
    );

    if (serieCreada == true) {
      recargarSeries();
    }
  }

  double calcularVolumenTotal(List<WorkoutSet> series) {
    return series.fold(
      0,
      (total, serie) => total + serie.volume,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutSession.routineName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: recargarSeries,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirPantallaAnadirSerie,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<WorkoutSet>>(
        future: seriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No se pudieron cargar las series',
                textAlign: TextAlign.center,
              ),
            );
          }

          final series = snapshot.data ?? [];
          final volumenTotal = calcularVolumenTotal(series);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                widget.workoutSession.routineName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Fecha: ${widget.workoutSession.workoutDate}'),
              if (widget.workoutSession.notes.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(widget.workoutSession.notes),
              ],
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text('Resumen'),
                  subtitle: Text(
                    'Series: ${series.length}\n'
                    'Volumen total: ${volumenTotal.toStringAsFixed(1)} kg',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Series realizadas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (series.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Todavía no has añadido series a este entrenamiento',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ...series.map((serie) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(serie.setNumber.toString()),
                      ),
                      title: Text(
                        serie.exerciseName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${serie.muscleGroup}\n'
                        '${serie.weightKg.toStringAsFixed(1)} kg x '
                        '${serie.repetitions} reps\n'
                        'Volumen: ${serie.volume.toStringAsFixed(1)} kg',
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