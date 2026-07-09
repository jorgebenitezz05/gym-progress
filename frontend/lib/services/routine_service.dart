import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/routine.dart';

class RoutineService {
  // Obtiene todas las rutinas desde el backend
  Future<List<Routine>> obtenerRutinas() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/routines');

    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = jsonDecode(respuesta.body);

      return datos.map((json) => Routine.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las rutinas');
    }
  }

  // Crea una nueva rutina en el backend
  Future<Routine> crearRutina({
    required String name,
    required String description,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/routines');

    final respuesta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
      }),
    );

    if (respuesta.statusCode == 200 || respuesta.statusCode == 201) {
      final datos = jsonDecode(respuesta.body);
      return Routine.fromJson(datos);
    } else {
      throw Exception('Error al crear la rutina');
    }
  }
}