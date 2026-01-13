import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 64),
              SizedBox(height: 16),
              Text('Entorno Totalmente Instalado', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Progrese App (GoRouter + Melos + Supabase)'),
            ],
          ),
        ),
      ),
    ),
  ],
);
