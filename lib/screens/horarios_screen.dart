import 'package:flutter/material.dart';

class HorarioClase {
  final String materia;
  final String profesor;
  final String salon;
  final String dia;
  final String horaInicio;
  final String horaFin;

  HorarioClase({
    required this.materia,
    required this.profesor,
    required this.salon,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
  });
}

final List<HorarioClase> horarios = [
  HorarioClase(
    materia: 'Redes I',
    profesor: 'Ing. Erick Montecillo',
    salon: 'Lab Redes - LT',
    dia: 'Lunes',
    horaInicio: '08:00',
    horaFin: '10:00',
  ),
  HorarioClase(
    materia: 'Telecomunicaciones',
    profesor: 'Ing. Erick Montecillo',
    salon: 'Lab Telemática - LT',
    dia: 'Miércoles',
    horaInicio: '10:00',
    horaFin: '12:00',
  ),
  // Agrega más
];

class HorariosScreen extends StatelessWidget {
  const HorariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text('Horarios'),
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: horarios.length,
        itemBuilder: (ctx, index) {
          final h = horarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF2D2D44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    h.horaInicio.split(':')[0],
                    style: const TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                h.materia,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${h.dia} | ${h.horaInicio} - ${h.horaFin}\n${h.profesor} | ${h.salon}',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        },
      ),
    );
  }
}
