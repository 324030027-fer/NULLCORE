import 'package:flutter/material.dart';
import 'teacher_profile_screen.dart';

class Contact {
  final String id;
  final String name;
  final String subject;
  final String email;
  final String phone;
  final String office;
  final String imageAsset;

  Contact({
    required this.id,
    required this.name,
    required this.subject,
    required this.email,
    required this.phone,
    required this.office,
    required this.imageAsset,
  });
}

final List<Contact> teachers = [
  Contact(
    id: '1',
    name: 'Ing. Erick Fernando Montecillo Olivares',
    subject: 'Redes y Telecomunicaciones',
    email: 'emontecillo@upjr.edu.mx',
    phone: '771 XXX XXXX',
    office: 'Laboratorio de Redes - LT',
    imageAsset: 'assets/teacher_erick.png',
  ),
  // Agrega más profesores
];

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text('Contactos'),
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (ctx, index) {
          final teacher = teachers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF2D2D44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(teacher.imageAsset),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                teacher.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                teacher.subject,
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF00E5FF),
                size: 16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherProfileScreen(teacher: teacher),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
