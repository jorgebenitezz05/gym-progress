import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../models/routine.dart';
import '../services/exercise_service.dart';
import '../services/routine_exercise_service.dart';

class AddExerciseToRoutineScreen extends StatefulWidget {
  final Routine routine;

  const AddExerciseToRoutineScreen({
    super.key,
    required this.routine,
  });

  @override
  State<AddExerciseToRoutineScreen> createState() =>
      _AddExerciseToRoutineScreenState();
}

class _AddExerciseToRoutineScreenState
    extends State<AddExerciseToRoutineScreen> {
  final ExerciseService exerciseService = ExerciseService();
  final RoutineExerciseService routineExerciseService =
      RoutineExerciseService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController orderController = TextEditingController();
  final TextEditingController setsController = TextEditingController(text: '3');
  final TextEditingController repetitionsController =
      TextEditingController(text: '8-12');
  final TextEditingController restController = TextEditingController(text: '90');
  final TextEditingController notesController = TextEditingController();

  late Future<List<Exercise>> ejerciciosFuture;

  int? selectedExerciseId;
  bool guardando = false;

  @override
  void initState() {
    super.initState();
    ejerciciosFuture = exerciseService.obtenerEjercicios();
  }

  Future<void> guardarEjercicioEnRutina() async {
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
      final int? orden = orderController.text.trim().isEmpty
          ? null
          : int.parse(orderController.text.trim());

      final int series = int.parse(setsController.text.trim());

      final int? descanso = restController.text.trim().isEmpty
          ? null
          : int.parse(restController.text.trim());

      await routineExerciseService.anadirEjercicioARutina(
        routineId: widget.routine.id,
        exerciseId: selectedExerciseId!,
        exerciseOrder: orden,
        targetSets: series,
        targetRepetitions: repetitionsController.text.trim(),
        restSeconds: descanso,
        notes: notesController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll('Exception: ', '')),
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
    orderController.dispose();
    setsController.dispose();
    repetitionsController.dispose();
    restController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir ejercicio'),
        centerTitle: true,
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
              child: Text('No se pudieron cargar los ejercicios'),
            );
          }

          final ejercicios = snapshot.data ?? [];

          if (ejercicios.isEmpty) {
            return const Center(
              child: Text(
                'Primero tienes que crear algún ejercicio',
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
                    widget.routine.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedExerciseId,
                    decoration: const InputDecoration(
                      labelText: 'Ejercicio',
                      border: OutlineInputBorder(),
                    ),
                    items: ejercicios.map((ejercicio) {
                      return DropdownMenuItem<int>(
                        value: ejercicio.id,
                        child: Text(
                          '${ejercicio.name} - ${ejercicio.muscleGroup}',
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
                    controller: orderController,
                    decoration: const InputDecoration(
                      labelText: 'Orden dentro de la rutina',
                      hintText: 'Si lo dejas vacío, se asigna automáticamente',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: setsController,
                    decoration: const InputDecoration(
                      labelText: 'Series objetivo',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Las series son obligatorias';
                      }

                      final numero = int.tryParse(value.trim());

                      if (numero == null || numero <= 0) {
                        return 'Introduce un número válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: repetitionsController,
                    decoration: const InputDecoration(
                      labelText: 'Repeticiones objetivo',
                      hintText: 'Ejemplo: 8-12',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Las repeticiones son obligatorias';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: restController,
                    decoration: const InputDecoration(
                      labelText: 'Descanso en segundos',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
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
                      onPressed: guardando ? null : guardarEjercicioEnRutina,
                      child: guardando
                          ? const CircularProgressIndicator()
                          : const Text('Guardar en rutina'),
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