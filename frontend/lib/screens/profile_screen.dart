import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.person_rounded, size: 64, color: Color(0xFF22C55E)),
              SizedBox(height: 24),
              Text('Perfil próximamente', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              Text('Pronto verás tu información personal aquí.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

