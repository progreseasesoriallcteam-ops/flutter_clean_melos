import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'main.dart'; // Import MyApp

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZATION: Production Config
  // This entry point is used for 'flutter build web -t lib/main_production.dart'
  await ApiClient.initialize(AppConfig.production);

  runApp(const MyApp());
}
