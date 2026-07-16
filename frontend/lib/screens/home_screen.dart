import 'package:flutter/material.dart';

import 'exercise_list_screen.dart';
import 'routine_list_screen.dart';
import 'workout_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Color principal de la aplicación
  static const Color colorPrincipal = Color(0xFF16A34A);

  /// Navega a otra pantalla
  void abrirPantalla(BuildContext context, Widget pantalla) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pantalla,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F7FA),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 10),

              // Logo principal
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: colorPrincipal,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: colorPrincipal.withOpacity(0.30),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.fitness_center,
                  size: 55,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "GymProgress",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Entrena más inteligente.\nRegistra todo tu progreso.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 40),

              _tarjetaOpcion(
                context: context,
                icono: Icons.fitness_center,
                titulo: "Ejercicios",
                descripcion: "Explora todos los ejercicios del gimnasio.",
                color: Colors.blue,
                pantalla: const ExerciseListScreen(),
              ),

              const SizedBox(height: 18),

              _tarjetaOpcion(
                context: context,
                icono: Icons.list_alt_rounded,
                titulo: "Rutinas",
                descripcion: "Organiza tus entrenamientos.",
                color: Colors.orange,
                pantalla: const RoutineListScreen(),
              ),

              const SizedBox(height: 18),

              _tarjetaOpcion(
                context: context,
                icono: Icons.sports_gymnastics,
                titulo: "Entrenamientos",
                descripcion: "Registra cada serie y cada repetición.",
                color: Colors.green,
                pantalla: const WorkoutListScreen(),
              ),

              const SizedBox(height: 18),

              _tarjetaOpcion(
                context: context,
                icono: Icons.bar_chart_rounded,
                titulo: "Estadísticas",
                descripcion: "Muy pronto podrás consultar tu progreso.",
                color: Colors.purple,
                pantalla: const WorkoutListScreen(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tarjetaOpcion({
    required BuildContext context,
    required IconData icono,
    required String titulo,
    required String descripcion,
    required Color color,
    required Widget pantalla,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => abrirPantalla(context, pantalla),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icono,
                  color: color,
                  size: 34,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      descripcion,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}