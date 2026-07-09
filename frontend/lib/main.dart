import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GymProgressApp());
}

class GymProgressApp extends StatelessWidget {
  const GymProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymProgress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Cambia esta IP por la IP de tu ordenador
  static const String backendUrl = 'http://10.0.2.2:8080/api/health';

  bool cargando = false;
  String mensaje = 'Pulsa el botón para comprobar la conexión con el backend';

  Future<void> comprobarConexion() async {
    setState(() {
      cargando = true;
      mensaje = 'Conectando con el backend...';
    });

    try {
      final respuesta = await http.get(Uri.parse(backendUrl));

      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body);

        setState(() {
          mensaje = datos['mensaje'] ?? 'Backend conectado correctamente';
        });
      } else {
        setState(() {
          mensaje = 'Error del servidor: ${respuesta.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        mensaje = 'No se pudo conectar con el backend';
      });
    } finally {
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymProgress'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fitness_center,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'Bienvenido a GymProgress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: cargando ? null : comprobarConexion,
                child: cargando
                    ? const CircularProgressIndicator()
                    : const Text('Comprobar conexión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}