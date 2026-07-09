import 'package:flutter/material.dart';

import '../services/exercise_service.dart';

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({super.key});

  @override
  State<CreateExerciseScreen> createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  final ExerciseService exerciseService = ExerciseService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectedMuscleGroup = 'PECHO';
  bool guardando = false;

  final List<String> muscleGroups = [
    'PECHO',
    'ESPALDA',
    'PIERNA',
    'HOMBRO',
    'BICEPS',
    'TRICEPS',
    'ABDOMINALES',
    'CARDIO',
  ];

  Future<void> guardarEjercicio() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      await exerciseService.crearEjercicio(
        name: nameController.text.trim(),
        muscleGroup: selectedMuscleGroup,
        description: descriptionController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo crear el ejercicio'),
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
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear ejercicio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del ejercicio',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedMuscleGroup,
                decoration: const InputDecoration(
                  labelText: 'Grupo muscular',
                  border: OutlineInputBorder(),
                ),
                items: muscleGroups.map((muscleGroup) {
                  return DropdownMenuItem(
                    value: muscleGroup,
                    child: Text(muscleGroup),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedMuscleGroup = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: guardando ? null : guardarEjercicio,
                  child: guardando
                      ? const CircularProgressIndicator()
                      : const Text('Guardar ejercicio'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}