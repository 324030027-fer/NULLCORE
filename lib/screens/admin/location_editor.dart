import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/map_location.dart';
import '../../providers/map_provider.dart';
import '../../widgets/grid_painter.dart';

class LocationEditor extends StatefulWidget {
  final MapLocation? existingLocation;
  const LocationEditor({super.key, this.existingLocation});

  @override
  State<LocationEditor> createState() => _LocationEditorState();
}

class _LocationEditorState extends State<LocationEditor> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _catCtrl;
  late TextEditingController _xCtrl;
  late TextEditingController _yCtrl;
  // Quitamos featuresCtrl porque el mapa simple no usa características detalladas, solo descripción.
  
  IconData _selectedIcon = Icons.place;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.existingLocation?.title ?? '');
    _descCtrl = TextEditingController(text: widget.existingLocation?.description ?? '');
    _catCtrl = TextEditingController(text: widget.existingLocation?.category ?? 'General');
    _xCtrl = TextEditingController(text: widget.existingLocation?.x.toStringAsFixed(4) ?? '');
    _yCtrl = TextEditingController(text: widget.existingLocation?.y.toStringAsFixed(4) ?? '');
    _selectedIcon = widget.existingLocation?.icon ?? Icons.place;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: Text(widget.existingLocation == null ? "Crear Ubicación" : "Editar Ubicación"),
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_titleCtrl, "Nombre", Icons.title),
              const SizedBox(height: 16),
              _buildTextField(_descCtrl, "Descripción", Icons.description, maxLines: 3),
              const SizedBox(height: 16),
              _buildTextField(_catCtrl, "Categoría", Icons.category),
              
              const SizedBox(height: 24),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D44),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Coordenadas Exactas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildCoordField(_xCtrl, "X")),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCoordField(_yCtrl, "Y")),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _pickCoordinates,
                        icon: const Icon(Icons.pin_drop, color: Color(0xFF00E5FF)),
                        label: const Text("SELECCIONAR EN MAPA", style: TextStyle(color: Color(0xFF00E5FF))),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF00E5FF)),
                          padding: const EdgeInsets.symmetric(vertical: 12)
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              FilledButton(
                onPressed: _saveLocation,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                child: const Text("GUARDAR CAMBIOS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF))),
        filled: true,
        fillColor: const Color(0xFF2D2D44),
      ),
      validator: (v) => v!.isEmpty ? "Requerido" : null,
    );
  }

  Widget _buildCoordField(TextEditingController ctrl, String label) {
    return TextFormField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black26,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0)
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  void _pickCoordinates() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const _MapCoordinatePicker()),
    );

    if (result != null && result is Offset) {
      setState(() {
        _xCtrl.text = result.dx.toStringAsFixed(4);
        _yCtrl.text = result.dy.toStringAsFixed(4);
      });
    }
  }

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<MapProvider>(context, listen: false);
      
      final newLoc = MapLocation(
        id: widget.existingLocation?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleCtrl.text,
        description: _descCtrl.text,
        category: _catCtrl.text,
        x: double.parse(_xCtrl.text),
        y: double.parse(_yCtrl.text),
        assetImage360: '', // No aplica para mapa aéreo simple
        icon: _selectedIcon,
      );

      // CORRECCIÓN: Usamos los métodos específicos para mapPoints
      if (widget.existingLocation == null) {
        provider.addMapPoint(newLoc);
      } else {
        provider.updateMapPoint(newLoc);
      }
      Navigator.pop(context);
    }
  }
}

class _MapCoordinatePicker extends StatefulWidget {
  const _MapCoordinatePicker();

  @override
  State<_MapCoordinatePicker> createState() => _MapCoordinatePickerState();
}

class _MapCoordinatePickerState extends State<_MapCoordinatePicker> {
  Offset? _tappedPos;
  Offset? _relativePos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Toca la ubicación"), 
        backgroundColor: Colors.black, 
        foregroundColor: Colors.white,
        actions: [
          if (_relativePos != null)
            IconButton(
              icon: const Icon(Icons.check, color: Color(0xFF00E5FF)),
              onPressed: () => Navigator.pop(context, _relativePos),
            )
        ],
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 5.0,
        constrained: false, 
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTapUp: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final double relativeX = details.localPosition.dx / box.size.width;
                final double relativeY = details.localPosition.dy / box.size.height;
                
                setState(() {
                  _tappedPos = details.localPosition;
                  _relativePos = Offset(relativeX, relativeY);
                });
              },
              child: Stack(
                children: [
                  Image.asset('assets/mapa_base.jpg'),
                  Positioned.fill(child: CustomPaint(painter: GridPainter(color: const Color(0xFF00E5FF).withOpacity(0.3), divisions: 10))),
                  
                  if (_tappedPos != null)
                    Positioned(
                      left: _tappedPos!.dx - 10,
                      top: _tappedPos!.dy - 10,
                      child: Container(
                        width: 20, height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.5), blurRadius: 10)]
                        ),
                      ),
                    )
                ],
              ),
            );
          }
        ),
      ),
      floatingActionButton: _relativePos != null ? FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context, _relativePos),
        label: const Text("CONFIRMAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.check, color: Colors.black),
        backgroundColor: const Color(0xFF00E5FF),
      ) : null,
    );
  }
}