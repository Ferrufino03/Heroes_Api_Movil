import 'package:api_movil_heroes/home_heroe.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: MainScreen(),
    );
  }
}
