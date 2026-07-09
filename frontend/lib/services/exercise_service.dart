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
}