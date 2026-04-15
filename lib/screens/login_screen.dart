import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 100, color: Color(0xFF6C63FF)),
            const SizedBox(height: 32),
            const Text(
              'NULLCORE MAPS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Tu nombre',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF00E5FF)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    context.read<AuthProvider>().login(name);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ingresa tu nombre')),
                    );
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('INGRESAR', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.read<AuthProvider>().loginAsGuest();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text(
                'Continuar como Invitado',
                style: TextStyle(color: Color(0xFF00E5FF)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
