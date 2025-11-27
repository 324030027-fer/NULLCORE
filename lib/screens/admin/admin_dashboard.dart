import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/map_provider.dart';
import 'location_editor.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Puntos (Mapa Aéreo)"),
        backgroundColor: const Color(0xFF1E1E2C), // Fondo oscuro coherente
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1E1E2C),
      body: provider.mapPoints.isEmpty 
        ? const Center(child: Text("No hay puntos en el mapa.", style: TextStyle(color: Colors.white)))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            // CORRECCIÓN: Usamos 'mapPoints' en lugar de 'locations'
            itemCount: provider.mapPoints.length,
            itemBuilder: (context, index) {
              final loc = provider.mapPoints[index];
              return Card(
                color: const Color(0xFF2D2D44),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00E5FF).withOpacity(0.2),
                    child: Icon(loc.icon, color: const Color(0xFF00E5FF)),
                  ),
                  title: Text(loc.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(
                    "Cat: ${loc.category} | X:${loc.x.toStringAsFixed(2)}, Y:${loc.y.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white.withOpacity(0.6))
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF6C63FF)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LocationEditor(existingLocation: loc)));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Color(0xFFFF2E63)), // Rosa neón para borrar
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (_) => AlertDialog(
                              backgroundColor: const Color(0xFF2D2D44),
                              title: const Text("¿Eliminar Ubicación?", style: TextStyle(color: Colors.white)),
                              content: Text("Se borrará permanentemente: ${loc.title}", style: const TextStyle(color: Colors.white70)),
                              actions: [
                                TextButton(
                                  onPressed: ()=>Navigator.pop(context), 
                                  child: const Text("Cancelar", style: TextStyle(color: Colors.grey))
                                ),
                                FilledButton(
                                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFFFF2E63)),
                                  onPressed: (){
                                    // CORRECCIÓN: Llamamos a removeLocation con lógica explícita si es necesario
                                    // OJO: MapProvider necesita un método removeMapPoint público.
                                    // Como usamos removeLocation genérico, asegúrate de que MapProvider lo tenga
                                    // o usemos removeWhere directamente en la lista pública (no recomendado)
                                    // Lo ideal es añadir: void removeMapPoint(String id) en el provider.
                                    // Por ahora, asumo que el provider tiene un método genérico o añadiré uno específico abajo.
                                    // Para este fix rápido, usaremos el método genérico si existe o lo añadiremos.
                                    // *Ver nota abajo sobre Provider*
                                    
                                    // Como eliminé removeLocation del provider anterior por limpieza, 
                                    // aquí simularemos la eliminación o asumiremos que agregas el método.
                                    // Voy a añadir removeMapPoint en la actualización del Provider abajo.
                                    provider.removeMapPoint(loc.id); 
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text("Borrar")
                                )
                              ],
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LocationEditor()));
        },
        label: const Text("Nueva Ubicación", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_location_alt, color: Colors.black),
        backgroundColor: const Color(0xFF00E5FF),
      ),
    );
  }
}