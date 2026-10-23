import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';

void main() => runApp(const TokoTegarApp());

class TokoTegarApp extends StatelessWidget {
  const TokoTegarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Tegar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6750A4),
      ),
      home: const RegistrationScreen(),
    );
  }
}