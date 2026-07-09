import 'package:flutter/material.dart';

import '../models/routine.dart';
import '../services/routine_service.dart';
import 'create_routine_screen.dart';

class RoutineListScreen extends StatefulWidget {
  const RoutineListScreen({super.key});

  @override
  State<RoutineListScreen> createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  final RoutineService routineService = RoutineService();

  late Future<List<Routine>> rutinasFuture;

  @override
  void initState() {
    super.initState();
    rutinasFuture = routineService.obtenerRutinas();
  }

  void recargarRutinas() {
    setState(() {
      rutinasFuture = routineService.obtenerRutinas();
    });
  }

  Future<void> abrirPantallaCrearRutina() async {
    final rutinaCreada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateRoutineScreen(),
      ),
    );

    if (rutinaCreada == true) {
      recargarRutinas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis rutinas'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: recargarRutinas,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirPantallaCrearRutina,
        child: const Icon(Icons.add),
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
              child: Text(
                'No se pudieron cargar las rutinas',
                textAlign: TextAlign.center,
              ),
            );
          }

          final rutinas = snapshot.data ?? [];

          if (rutinas.isEmpty) {
            return const Center(
              child: Text(
                'Todavía no hay rutinas creadas',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rutinas.length,
            itemBuilder: (context, index) {
              final rutina = rutinas[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.list_alt),
                  title: Text(
                    rutina.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(rutina.description),
                ),
              );
            },
          );
        },
      ),
    );
  }
}