import 'package:flutter/material.dart';
import '../models/map_location.dart';

// --- MARCADOR NEÓN ---
class MapMarker extends StatelessWidget {
  final MapLocation location;
  final bool isSelected;
  final VoidCallback onTap;

  const MapMarker({super.key, required this.location, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double size = 40.0;
    final Color mainColor = isSelected ? const Color(0xFF00E5FF) : const Color(0xFF6C63FF);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.3 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: mainColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [BoxShadow(color: mainColor.withOpacity(0.6), blurRadius: 10, spreadRadius: 2)]
              ),
              child: Icon(location.icon, color: Colors.white, size: 20),
            ),
            Positioned(
              top: size + 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2C).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4)]
                ),
                constraints: const BoxConstraints(maxWidth: 140), 
                child: Text(
                  location.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANEL DE INFORMACIÓN DETALLADA (Con campos para fotos) ---
class LocationDetailSheet extends StatelessWidget {
  final MapLocation location;

  const LocationDetailSheet({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, -5))],
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1))
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40, height: 4, 
                margin: const EdgeInsets.symmetric(vertical: 16), 
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))
              )
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CABECERA
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.2), shape: BoxShape.circle),
                        child: Icon(location.icon, color: const Color(0xFF6C63FF), size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(location.category.toUpperCase(), style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.5)),
                            const SizedBox(height: 4),
                            Text(location.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // SECCIÓN: DESCRIPCIÓN
                  const Text("DESCRIPCIÓN", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10)
                    ),
                    child: Text(
                      location.description.isNotEmpty ? location.description : "Sin descripción disponible.", 
                      style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14)
                    ),
                  ),
                  
                  const SizedBox(height: 24),

                  // SECCIÓN: CARACTERÍSTICAS (Aunque esté vacío en mapPoints, mostramos el campo para rellenar después)
                  const Text("CARACTERÍSTICAS", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10)
                    ),
                    // Usamos un texto placeholder si no hay características
                    child: Text(
                      "• Información pendiente de agregar.\n• Espacio reservado para detalles técnicos.",
                      style: TextStyle(color: Colors.white.withOpacity(0.5), height: 1.5, fontSize: 14, fontStyle: FontStyle.italic)
                    ),
                  ),

                  const SizedBox(height: 24),

                  // SECCIÓN: FOTOS DEL LUGAR (Placeholders)
                  const Text("FOTOS DEL LUGAR", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // Mostramos 3 placeholders fijos
                      itemCount: 3, 
                      itemBuilder: (ctx, i) => Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E2C),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white12, style: BorderStyle.solid)
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_a_photo, color: Colors.white.withOpacity(0.2), size: 24),
                              const SizedBox(height: 8),
                              Text("Foto ${i + 1}", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}