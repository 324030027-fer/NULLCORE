import 'package:flutter/material.dart';
import '../models/map_location.dart';
import '../screens/panorama_viewer.dart';

// --- MARCADOR NEÓN CIRCULAR ---
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

// --- PANEL DE INFORMACIÓN DETALLADA ---
class LocationDetailSheet extends StatelessWidget {
  final MapLocation location;
  final ScrollController? scrollController; // CORRECCIÓN: Agregado el controlador

  const LocationDetailSheet({
    super.key, 
    required this.location, 
    this.scrollController // CORRECCIÓN: Constructor actualizado
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Altura dinámica controlada por DraggableScrollableSheet
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, -5))],
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1))
      ),
      child: SingleChildScrollView(
        controller: scrollController, // CORRECCIÓN: Conectado al scroll del padre
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(child: Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
            
            // Header
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
            
            // Descripción
            _buildSectionTitle("DESCRIPCIÓN"),
            const SizedBox(height: 8),
            Text(location.description, style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14)),
            const SizedBox(height: 24),

            // Fotos del Edificio (Placeholders)
            if (location.equipmentImages.isNotEmpty) ...[
              _buildSectionTitle("VISTA DEL EDIFICIO"),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: location.equipmentImages.length,
                  itemBuilder: (ctx, i) => Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: AssetImage(location.equipmentImages[i]), fit: BoxFit.cover),
                      border: Border.all(color: Colors.white12)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Carreras y Laboratorios
            if (location.careers.isNotEmpty) ...[
              _buildSectionTitle("CARRERAS Y LABORATORIOS"),
              const SizedBox(height: 12),
              ...location.careers.map((career) => _buildCareerSection(context, career)),
            ] else ...[
              _buildSectionTitle("CARACTERÍSTICAS"),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
                child: Text(location.features, style: const TextStyle(color: Colors.white70, height: 1.5, fontSize: 14)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2));
  }

  Widget _buildCareerSection(BuildContext context, CareerInfo career) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10)
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(career.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          leading: const Icon(Icons.school, color: Color(0xFF00E5FF)),
          childrenPadding: const EdgeInsets.all(16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: career.labs.map((lab) => _buildLabItem(context, lab)).toList(),
        ),
      ),
    );
  }

  Widget _buildLabItem(BuildContext context, LabInfo lab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(lab.imageThumbnail, width: 60, height: 60, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lab.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Encargado: ${lab.inCharge}", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
                    Text(lab.contact, style: TextStyle(color: const Color(0xFF00E5FF), fontSize: 11)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(lab.description, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
          
          if (lab.asset360 != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  final tempLoc = MapLocation(
                    id: 'TEMP_LAB', title: lab.name, description: '', category: 'Laboratorio', x: 0, y: 0, assetImage360: lab.asset360!,
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PanoramaViewer(initialLocation: tempLoc)));
                },
                icon: const Icon(Icons.threesixty, size: 18),
                label: const Text("VER RECORRIDO 360"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00E5FF),
                  side: const BorderSide(color: Color(0xFF00E5FF)),
                  padding: const EdgeInsets.symmetric(vertical: 8)
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}