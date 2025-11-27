import 'package:flutter/material.dart';
import '../models/map_location.dart';

class MapProvider extends ChangeNotifier {
  
  // --- LISTA 1: PUNTOS PARA EL MAPA AÉREO (Solo Información) ---
  final List<MapLocation> _mapPoints = [
    MapLocation(
      id: 'RECTORIA',
      title: 'RECTORÍA',
      description: 'Aquí encontrarás las oficinas relacionadas con trámites, servicios escolares y la sección de rectoría donde se encuentran las autoridades de la institución.',
      category: 'Administración',
      x: 0.1016, y: 0.3836,
      assetImage360: '', // No se usa en mapa
      icon: Icons.account_balance,
    ),
    MapLocation(
      id: 'BIBLIOTECA',
      title: 'BIBLIOTECA',
      description: 'Podrás encontrar la parte de biblioteca, un lugar lleno de libros interesantes que podrán ayudarte en la formación y preparación de tu carrera.',
      category: 'Estudio',
      x: 0.1195, y: 0.2830,
      assetImage360: '',
      icon: Icons.local_library,
    ),
    MapLocation(
      id: 'UD2',
      title: 'UD2 (UNIDAD DE DOCENCIA 2)',
      description: 'Salones de clases de: IFI, ITR, IRT, IMT, IME, LAG.\nTambién encontrarás el AUDITORIO UD2 y cubículos de maestros.',
      category: 'Docencia',
      x: 0.2332, y: 0.8767,
      assetImage360: '',
      icon: Icons.class_outlined,
    ),
    MapLocation(
      id: 'UD1',
      title: 'UD1 (UNIDAD DE DOCENCIA 1)',
      description: 'Salones de clase de: ISA, IPL (Ing Industrial), IMA.\nAuditorio de UD1 y cubículos de profesores.',
      category: 'Docencia',
      x: 0.7996, y: 0.5377,
      assetImage360: '',
      icon: Icons.school,
    ),
    MapLocation(
      id: 'CAFETERIA',
      title: 'CAFETERÍA',
      description: 'En cafetería podrás comprar tus productos alimenticios, snacks y pasar el tiempo en tu receso.',
      category: 'Servicios',
      x: 0.5999, y: 0.3271,
      assetImage360: '',
      icon: Icons.restaurant,
    ),
    MapLocation(
      id: 'LT_MAP',
      title: 'LT (LABORATORIOS)',
      description: 'Salida del centro de laboratorios, camino hacia la entrada de UPJR.',
      category: 'Laboratorio',
      x: 0.8000, y: 0.1365,
      assetImage360: '',
      icon: Icons.science,
    ),
    MapLocation(
      id: 'CANCHA',
      title: 'CANCHA DE USOS MÚLTIPLES',
      description: 'Cancha techada donde se practica basketball y volleyball. Aquí se desarrollan eventos de la institución.',
      category: 'Deportes',
      x: 0.3594, y: 0.3046,
      assetImage360: '',
      icon: Icons.sports_basketball,
    ),
  ];

  // --- LISTA 2: PUNTOS PARA EL RECORRIDO VIRTUAL 360 (Edificio LT) ---
  final List<MapLocation> _tourPoints = [
    MapLocation(
      id: 'E1',
      title: 'Entrada Trasera',
      description: 'Acceso posterior del edificio.',
      category: 'Entrada',
      x: 0, y: 0, // No importa en tour
      assetImage360: 'assets/E1.jpg',
      linkedIds: ['E2'],
    ),
    MapLocation(
      id: 'E2',
      title: 'Esquina Entrada',
      description: '',
      category: 'Entrada',
      x: 0, y: 0,
      assetImage360: 'assets/E2.jpg',
      linkedIds: ['E1', 'P1'],
    ),
    MapLocation(
      id: 'P1',
      title: 'Pasillo 1',
      description: '',
      category: 'Pasillo',
      x: 0, y: 0,
      assetImage360: 'assets/P1.jpg',
      linkedIds: ['E1', 'P3'],
    ),
    MapLocation(
      id: 'P3',
      title: 'Pasillo Central',
      description: '',
      category: 'Pasillo',
      x: 0, y: 0,
      assetImage360: 'assets/P3.jpg',
      linkedIds: ['P1', 'S2'],
    ),
    MapLocation(
      id: 'S2',
      title: 'Lab. Software (S2)',
      description: '',
      category: 'Laboratorio',
      x: 0, y: 0,
      assetImage360: 'assets/S2.jpg',
      linkedIds: ['S1', 'P3'],
    ),
    MapLocation(
      id: 'S1',
      title: 'Lab. Redes (S1)',
      description: '',
      category: 'Laboratorio',
      x: 0, y: 0,
      assetImage360: 'assets/S1.jpg',
      linkedIds: ['S2'],
    ),
  ];

  MapLocation? _selectedMapLocation;

  // Getters separados
  List<MapLocation> get mapPoints => _mapPoints;
  List<MapLocation> get tourPoints => _tourPoints;
  
  MapLocation? get selectedMapLocation => _selectedMapLocation;

  // Seleccionar punto en el mapa aéreo
  void selectMapLocation(MapLocation? location) {
    _selectedMapLocation = location;
    notifyListeners();
  }

  // Buscar punto del tour por ID (para navegación flechas)
  MapLocation getTourLocationById(String id) {
    return _tourPoints.firstWhere((loc) => loc.id == id, orElse: () => _tourPoints.first);
  }

  // Métodos de Admin (Añadir al mapa aéreo)
  void addMapPoint(MapLocation location) {
    _mapPoints.add(location);
    notifyListeners();
  }
  
  void updateMapPoint(MapLocation location) {
    final index = _mapPoints.indexWhere((l) => l.id == location.id);
    if(index != -1) {
      _mapPoints[index] = location;
      notifyListeners();
    }
  }
    void removeMapPoint(String id) {
    _mapPoints.removeWhere((l) => l.id == id);
    // Si el punto eliminado estaba seleccionado, deseleccionarlo
    if (_selectedMapLocation?.id == id) {
      _selectedMapLocation = null;
    }
    notifyListeners();
  }
}
