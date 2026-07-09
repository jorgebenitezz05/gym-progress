import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/workout_session.dart';
import '../models/workout_set.dart';

class WorkoutService {
  // Obtiene todos los entrenamientos registrados
  Future<List<WorkoutSession>> obtenerEntrenamientos() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/workouts');

    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = jsonDecode(respuesta.body);

      return datos.map((json) => WorkoutSession.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los entrenamientos');
    }
  }

  // Crea una nueva sesión de entrenamiento
  Future<WorkoutSession> crearEntrenamiento({
    required int routineId,
    required String workoutDate,
    required String notes,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/workouts');

    final respuesta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'routineId': routineId,
        'workoutDate': workoutDate,
        'notes': notes,
      }),
    );

    if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
      final datos = jsonDecode(respuesta.body);
      return WorkoutSession.fromJson(datos);
    } else {
      throw Exception('Error al crear el entrenamiento');
    }
  }

  // Obtiene las series de un entrenamiento
  Future<List<WorkoutSet>> obtenerSeriesDeEntrenamiento(
    int workoutSessionId,
  ) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/workouts/$workoutSessionId/sets',
    );

    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = jsonDecode(respuesta.body);

      return datos.map((json) => WorkoutSet.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las series del entrenamiento');
    }
  }

  // Añade una serie a un entrenamiento
  Future<WorkoutSet> anadirSerieAEntrenamiento({
    required int workoutSessionId,
    required int exerciseId,
    required int setNumber,
    required double weightKg,
    required int repetitions,
    required String notes,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/workouts/$workoutSessionId/exercises/$exerciseId/sets',
    );

    final respuesta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'setNumber': setNumber,
        'weightKg': weightKg,
        'repetitions': repetitions,
        'notes': notes,
      }),
    );

    if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
      final datos = jsonDecode(respuesta.body);
      return WorkoutSet.fromJson(datos);
    } else {
      throw Exception('Error al añadir la serie');
    }
  }
}