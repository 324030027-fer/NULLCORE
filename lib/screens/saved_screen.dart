import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/map_provider.dart';
import 'panorama_viewer.dart';
import 'horarios_screen.dart'; // ← Asegúrate de crear este archivo
import 'contacts_screen.dart'; // ← Asegúrate de crear este archivo

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    final startingPoint = provider.getTourLocationById('E1');

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER CON LOGO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "RECORRIDO\nVIRTUAL",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Explora el campus hoy.",
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                      ],
                    ),
                    Image.asset('assets/logo.png', width: 60, height: 60),
                  ],
                ),

                const SizedBox(height: 60),

                // TARJETA ÚNICA: RECORRIDO LT
                const Text(
                  "DISPONIBLE AHORA",
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PanoramaViewer(initialLocation: startingPoint),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: AssetImage('assets/E1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Gradiente Oscuro para texto
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xFF1E1E2C)],
                            ),
                          ),
                        ),
                        // Contenido
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C63FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "COMPLETO",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "RECORRIDO LT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.vrpano,
                                    color: Color(0xFF00E5FF),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Entradas • Pasillos • Laboratorios",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Botón Play
                        Positioned(
                          right: 20,
                          top: 20,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white54),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // --- PERFIL DEL PROFESOR (Ícono, correo, teléfono) ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D44),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF00E5FF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ING. ERICK FERNANDO MONTECILLO",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 16,
                                  color: Color(0xFF00E5FF),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "emontecillo@upjr.edu.mx",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Color(0xFF00E5FF),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "+52 771 123 4567",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- BOTONES HORARIOS Y CONTACTOS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HorariosScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.schedule, size: 20),
                        label: const Text(
                          "HORARIOS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF00E5FF),
                          side: const BorderSide(
                            color: Color(0xFF00E5FF),
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ContactsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.contacts, size: 20),
                        label: const Text(
                          "CONTACTOS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF00E5FF),
                          side: const BorderSide(
                            color: Color(0xFF00E5FF),
                            width: 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
