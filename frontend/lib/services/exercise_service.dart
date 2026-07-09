import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/exercise.dart';

class ExerciseService {
  // Obtiene todos los ejercicios desde el backend
  Future<List<Exercise>> obtenerEjercicios() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/exercises');

    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = jsonDecode(respuesta.body);

      return datos.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los ejercicios');
    }
  }

  // Crea un nuevo ejercicio en el backend
  Future<Exercise> crearEjercicio({
    required String name,
    required String muscleGroup,
    required String description,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/exercises');

    final respuesta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'muscleGroup': muscleGroup,
        'description': description,
      }),
    );

    if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
      final datos = jsonDecode(respuesta.body);
      return Exercise.fromJson(datos);
    } else {
      throw Exception('Error al crear el ejercicio');
    }
  }
}