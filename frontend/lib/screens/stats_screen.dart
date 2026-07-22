import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.bar_chart_rounded, size: 64, color: Color(0xFF22C55E)),
              SizedBox(height: 24),
              Text('Estadísticas próximamente', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('Estamos preparando tu panel de métricas.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

