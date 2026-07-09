import 'package:flutter/material.dart';

import '../models/routine.dart';
import '../services/routine_service.dart';
import '../services/workout_service.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final RoutineService routineService = RoutineService();
  final WorkoutService workoutService = WorkoutService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController notesController = TextEditingController();

  late Future<List<Routine>> rutinasFuture;

  int? selectedRoutineId;
  DateTime selectedDate = DateTime.now();
  bool guardando = false;

  @override
  void initState() {
    super.initState();
    rutinasFuture = routineService.obtenerRutinas();
  }

  String formatearFecha(DateTime fecha) {
    final year = fecha.year.toString().padLeft(4, '0');
    final month = fecha.month.toString().padLeft(2, '0');
    final day = fecha.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> seleccionarFecha() async {
    final fechaElegida = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (fechaElegida != null) {
      setState(() {
        selectedDate = fechaElegida;
      });
    }
  }

  Future<void> guardarEntrenamiento() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedRoutineId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona una rutina'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      await workoutService.crearEntrenamiento(
        routineId: selectedRoutineId!,
        workoutDate: formatearFecha(selectedDate),
        notes: notesController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo crear el entrenamiento'),
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
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear entrenamiento'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Routine>>(
        future: rutinasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('No se pudieron cargar las rutinas'),
            );
          }

          final rutinas = snapshot.data ?? [];

          if (rutinas.isEmpty) {
            return const Center(
              child: Text(
                'Primero tienes que crear una rutina',
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
                  DropdownButtonFormField<int>(
                    value: selectedRoutineId,
                    decoration: const InputDecoration(
                      labelText: 'Rutina',
                      border: OutlineInputBorder(),
                    ),
                    items: rutinas.map((rutina) {
                      return DropdownMenuItem<int>(
                        value: rutina.id,
                        child: Text(rutina.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoutineId = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Selecciona una rutina';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Fecha del entrenamiento'),
                    subtitle: Text(formatearFecha(selectedDate)),
                    trailing: const Icon(Icons.calendar_month),
                    onTap: seleccionarFecha,
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
                      onPressed: guardando ? null : guardarEntrenamiento,
                      child: guardando
                          ? const CircularProgressIndicator()
                          : const Text('Guardar entrenamiento'),
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