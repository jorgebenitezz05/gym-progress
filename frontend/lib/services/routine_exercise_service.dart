import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/routine_exercise.dart';

class RoutineExerciseService {
  // Obtiene los ejercicios que pertenecen a una rutina
  Future<List<RoutineExercise>> obtenerEjerciciosDeRutina(int routineId) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/routines/$routineId/exercises');

    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = jsonDecode(respuesta.body);

      return datos.map((json) => RoutineExercise.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los ejercicios de la rutina');
    }
  }

  // Añade un ejercicio existente a una rutina
  Future<RoutineExercise> anadirEjercicioARutina({
    required int routineId,
    required int exerciseId,
    int? exerciseOrder,
    required int targetSets,
    required String targetRepetitions,
    int? restSeconds,
    String? notes,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/routines/$routineId/exercises/$exerciseId',
    );

    final respuesta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'exerciseOrder': exerciseOrder,
        'targetSets': targetSets,
        'targetRepetitions': targetRepetitions,
        'restSeconds': restSeconds,
        'notes': notes,
      }),
    );

    if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
      final datos = jsonDecode(respuesta.body);
      return RoutineExercise.fromJson(datos);
    }

    if (respuesta.statusCode == 409) {
      throw Exception('Este ejercicio ya está añadido a la rutina');
    }

    throw Exception('Error al añadir el ejercicio a la rutina');
  }
}