import 'package:flutter/material.dart';

import '../services/routine_service.dart';

class CreateRoutineScreen extends StatefulWidget {
  const CreateRoutineScreen({super.key});

  @override
  State<CreateRoutineScreen> createState() => _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends State<CreateRoutineScreen> {
  final RoutineService routineService = RoutineService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool guardando = false;

  Future<void> guardarRutina() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      await routineService.crearRutina(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo crear la rutina'),
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
        title: const Text('Crear rutina'),
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
                  labelText: 'Nombre de la rutina',
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
                  onPressed: guardando ? null : guardarRutina,
                  child: guardando
                      ? const CircularProgressIndicator()
                      : const Text('Guardar rutina'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}