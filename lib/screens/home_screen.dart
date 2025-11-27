import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/map_provider.dart';
import '../widgets/map_widgets.dart';
import '../widgets/grid_painter.dart';
import 'saved_screen.dart';
import 'admin/admin_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  static final List<Widget> _widgetOptions = <Widget>[
    const MapView(),
    const SavedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      backgroundColor: const Color(0xFF1E1E2C),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D44).withOpacity(0.95), 
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E5FF).withOpacity(0.15), 
                blurRadius: 20, 
                offset: const Offset(0, 5)
              )
            ],
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1)
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.map_rounded, "MAPA"),
                  Container(width: 1, height: 20, color: Colors.white12), 
                  _buildNavItem(1, Icons.vrpano, "RECORRIDO"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFF00E5FF) : Colors.grey;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00E5FF).withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.0))
            ]
          ],
        ),
      ),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final TransformationController _transformer = TransformationController();
  bool _showGrid = false; 

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    return Stack(
      children: [
        // 1. MAPA FULL SCREEN
        Positioned.fill(
          child: GestureDetector(
            onTap: () => mapProvider.selectMapLocation(null),
            child: InteractiveViewer(
              transformationController: _transformer,
              minScale: 0.5,
              maxScale: 5.0,
              boundaryMargin: const EdgeInsets.all(300),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.0, 
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset('assets/mapa_base.jpg', fit: BoxFit.cover, width: constraints.maxWidth, height: constraints.maxHeight),
                          
                          if (_showGrid)
                            Positioned.fill(child: CustomPaint(painter: GridPainter(color: const Color(0xFF00E5FF).withOpacity(0.5), divisions: 10))),

                          ...mapProvider.mapPoints.map((loc) {
                            return Positioned(
                              left: (loc.x * constraints.maxWidth) - 20, 
                              top: (loc.y * constraints.maxHeight) - 20, 
                              width: 40,
                              height: 40,
                              child: MapMarker(
                                location: loc,
                                isSelected: mapProvider.selectedMapLocation?.id == loc.id,
                                onTap: () => mapProvider.selectMapLocation(loc),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        // 2. BARRA SUPERIOR (HEADER LIMPIO)
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 16, left: 24, right: 24),
            // Degradado sutil para leer texto sobre el mapa
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFF1E1E2C).withOpacity(0.8), const Color(0xFF1E1E2C).withOpacity(0.0)]
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TEXTO UPJR MAPA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("UPJR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 2)),
                    Text("MAPA CAMPUS", style: TextStyle(color: const Color(0xFF00E5FF).withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 3)),
                  ],
                ),
                // LOGO LIMPIO (Sin efectos)
                Image.asset(
                  'assets/logo.png',
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
        ),

        // 3. BOTÓN ADMIN (Discreto)
        Positioned(
          right: 20,
          bottom: 110,
          child: FloatingActionButton(
            heroTag: 'admin_tools',
            backgroundColor: const Color(0xFF2D2D44),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.white.withOpacity(0.1))),
            elevation: 10,
            child: const Icon(Icons.add_location_alt_outlined, color: Color(0xFF00E5FF)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDashboard())),
          ),
        ),

        // 4. PANEL DE DETALLE MEJORADO
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutExpo,
          left: 0, right: 0,
          bottom: mapProvider.selectedMapLocation != null ? 0 : -800,
          child: mapProvider.selectedMapLocation != null
              ? LocationDetailSheet(location: mapProvider.selectedMapLocation!)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}