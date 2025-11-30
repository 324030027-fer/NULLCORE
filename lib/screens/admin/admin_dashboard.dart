import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/map_provider.dart';
import 'location_editor.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Puntos (Mapa Aéreo)"),
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1E1E2C),
      body: provider.mapPoints.isEmpty
          ? const Center(
              child: Text(
                "No hay puntos en el mapa.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.mapPoints.length,
              itemBuilder: (context, index) {
                final loc = provider.mapPoints[index];
                return Card(
                  color: const Color(0xFF2D2D44),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF00E5FF).withOpacity(0.2),
                      child: Icon(loc.icon, color: const Color(0xFF00E5FF)),
                    ),
                    title: Text(
                      loc.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Cat: ${loc.category} | X:${loc.x.toStringAsFixed(2)}, Y:${loc.y.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF6C63FF)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LocationEditor(location: loc),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Color(0xFFFF2E63)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: const Color(0xFF2D2D44),
                                title: const Text(
                                  "¿Eliminar Ubicación?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  "Se borrará permanentemente: ${loc.title}",
                                  style:
                                      const TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFFFF2E63),
                                    ),
                                    onPressed: () {
                                      provider.mapPoints.removeAt(index);
                                      provider.notifyListeners();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Borrar"),
                                  ),
                                ],
                              ),
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
          // Aquí luego crearemos una ventana para agregar uno nuevo real
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Función pendiente de agregar")),
          );
        },
        label: const Text(
          "Nueva Ubicación",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.add_location_alt, color: Colors.black),
        backgroundColor: const Color(0xFF00E5FF),
      ),
    );
  }
}
