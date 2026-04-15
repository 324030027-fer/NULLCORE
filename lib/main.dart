import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/map_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFF00E5FF),
          tertiary: const Color(0xFFFF2E63),
          surface: Colors.white,
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) {
          if (auth.isLoggedIn) {
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
