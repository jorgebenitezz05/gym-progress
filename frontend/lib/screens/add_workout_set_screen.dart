import 'package:flutter/material.dart';

import '../models/routine_exercise.dart';
import '../models/workout_session.dart';
import '../services/routine_exercise_service.dart';
import '../services/workout_service.dart';

class AddWorkoutSetScreen extends StatefulWidget {
  final WorkoutSession workoutSession;

  const AddWorkoutSetScreen({
    super.key,
    required this.workoutSession,
  });

  @override
  State<AddWorkoutSetScreen> createState() => _AddWorkoutSetScreenState();
}

class _AddWorkoutSetScreenState extends State<AddWorkoutSetScreen> {
  final RoutineExerciseService routineExerciseService =
      RoutineExerciseService();

  final WorkoutService workoutService = WorkoutService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController setNumberController =
      TextEditingController(text: '1');
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repetitionsController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  late Future<List<RoutineExercise>> ejerciciosRutinaFuture;

  int? selectedExerciseId;
  bool guardando = false;

  @override
  void initState() {
    super.initState();

    ejerciciosRutinaFuture =
        routineExerciseService.obtenerEjerciciosDeRutina(
      widget.workoutSession.routineId,
    );
  }

  Future<void> guardarSerie() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedExerciseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un ejercicio'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      await workoutService.anadirSerieAEntrenamiento(
        workoutSessionId: widget.workoutSession.id,
        exerciseId: selectedExerciseId!,
        setNumber: int.parse(setNumberController.text.trim()),
        weightKg: double.parse(
          weightController.text.trim().replaceAll(',', '.'),
        ),
        repetitions: int.parse(repetitionsController.text.trim()),
        notes: notesController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar la serie'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    setNumberController.dispose();
    weightController.dispose();
    repetitionsController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir serie'),
        centerTitle: true,
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

          if (ejercicios.isEmpty) {
            return const Center(
              child: Text(
                'Esta rutina no tiene ejercicios. Añade ejercicios a la rutina antes de registrar series.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Text(
                    widget.workoutSession.routineName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Fecha: ${widget.workoutSession.workoutDate}'),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedExerciseId,
                    decoration: const InputDecoration(
                      labelText: 'Ejercicio',
                      border: OutlineInputBorder(),
                    ),
                    items: ejercicios.map((ejercicioRutina) {
                      return DropdownMenuItem<int>(
                        value: ejercicioRutina.exerciseId,
                        child: Text(
                          '${ejercicioRutina.exerciseName} - ${ejercicioRutina.muscleGroup}',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedExerciseId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Selecciona un ejercicio';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: setNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Número de serie',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final numero = int.tryParse(value ?? '');

                      if (numero == null || numero <= 0) {
                        return 'Introduce un número de serie válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      labelText: 'Peso en kg',
                      hintText: 'Ejemplo: 40',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      final texto = value?.replaceAll(',', '.') ?? '';
                      final numero = double.tryParse(texto);

                      if (numero == null || numero < 0) {
                        return 'Introduce un peso válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: repetitionsController,
                    decoration: const InputDecoration(
                      labelText: 'Repeticiones',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final numero = int.tryParse(value ?? '');

                      if (numero == null || numero <= 0) {
                        return 'Introduce repeticiones válidas';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notas',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: guardando ? null : guardarSerie,
                      child: guardando
                          ? const CircularProgressIndicator()
                          : const Text('Guardar serie'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}