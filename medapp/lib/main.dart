import 'package:flutter/material.dart';
import 'package:medapp/config/app_config.dart';
import 'package:medapp/flavor/main_development.dart' as dev;

void main() => dev.main();

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router();
  }
}
