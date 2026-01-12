import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZATION: Enforce Development Config by default (Local-First)
  await ApiClient.initialize(AppConfig.development);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Progrese Dev',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      routerConfig: router,
    );
  }
}
