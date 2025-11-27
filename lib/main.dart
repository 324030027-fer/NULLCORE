import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/map_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: const NullCoreMapsApp(),
    ),
  );
}

class NullCoreMapsApp extends StatelessWidget {
  const NullCoreMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NULLCORE MAPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat', // Si no tienes la fuente, usará la default, pero la configuro.
        scaffoldBackgroundColor: const Color(0xFFF0F4F8), // Blanco grisáceo moderno
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF), // Violeta moderno
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFF00E5FF), // Cian eléctrico
          tertiary: const Color(0xFFFF2E63), // Rosa neón para acentos
          surface: Colors.white,
        ),
        // Personalizamos botones elevados por defecto
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}