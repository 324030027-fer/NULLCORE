import 'package:flutter/material.dart';
import '../models/map_location.dart';

class MapProvider extends ChangeNotifier {
  
  // --- LISTA 1: PUNTOS PARA EL MAPA AÉREO ---
  final List<MapLocation> _mapPoints = [
    MapLocation(
      id: 'RECTORIA',
      title: 'RECTORÍA',
      description:
          'Aquí encontrarás las oficinas relacionadas con trámites, servicios escolares y la sección de rectoría donde se encuentran las autoridades de la institución.',
      category: 'Administración',
      x: 0.1016,
      y: 0.3836,
      assetImage360: '',
      icon: Icons.account_balance,
    ),
    MapLocation(
      id: 'BIBLIOTECA',
      title: 'BIBLIOTECA',
      description:
          'Podrás encontrar la parte de biblioteca, un lugar lleno de libros interesantes que podrán ayudarte en la formación y preparación de tu carrera.',
      category: 'Estudio',
      x: 0.1195,
      y: 0.2830,
      assetImage360: '',
      icon: Icons.local_library,
    ),
    MapLocation(
      id: 'UD2',
      title: 'UD2 (UNIDAD DE DOCENCIA 2)',
      description:
          'Salones de clases de: IFI, ITR, IRT, IMT, IME, LAG.\nTambién encontrarás el AUDITORIO UD2 y cubículos de maestros.',
      category: 'Docencia',
      x: 0.2332,
      y: 0.8767,
      assetImage360: '',
      icon: Icons.class_outlined,
    ),
    MapLocation(
      id: 'UD1',
      title: 'UD1 (UNIDAD DE DOCENCIA 1)',
      description:
          'Salones de clase de: ISA, IPL (Ing Industrial), IMA.\nAuditorio de UD1 y cubículos de profesores.',
      category: 'Docencia',
      x: 0.7996,
      y: 0.5377,
      assetImage360: '',
      icon: Icons.school,
    ),
    MapLocation(
      id: 'CAFETERIA',
      title: 'CAFETERÍA',
      description:
          'En cafetería podrás comprar tus productos alimenticios, snacks y pasar el tiempo en tu receso.',
      category: 'Servicios',
      x: 0.5999,
      y: 0.3271,
      assetImage360: '',
      icon: Icons.restaurant,
    ),
    MapLocation(
      id: 'LT_MAP',
      title: 'LT (LABORATORIOS)',
      description:
          'Salida del centro de laboratorios, camino hacia la entrada de UPJR.',
      category: 'Laboratorio',
      x: 0.8000,
      y: 0.1365,
      assetImage360: '',
      icon: Icons.science,
    ),
    MapLocation(
      id: 'CANCHA',
      title: 'CANCHA DE USOS MÚLTIPLES',
      description:
          'Cancha techada donde se practica basketball y volleyball. Aquí se desarrollan eventos de la institución.',
      category: 'Deportes',
      x: 0.3594,
      y: 0.3046,
      assetImage360: '',
      icon: Icons.sports_basketball,
    ),
  ];

  // --- LISTA 2: PUNTOS DE TOUR 360 ---
  final List<MapLocation> _tourPoints = [
    MapLocation(
      id: 'E1',
      title: 'Entrada Trasera',
      description: 'Acceso posterior del edificio.',
      category: 'Entrada',
      x: 0,
      y: 0,
      assetImage360: 'assets/E1.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'E2', yaw: 90, pitch: -12),
      ],
    ),
    MapLocation(
      id: 'E2',
      title: 'Esquina Entrada',
      description: '',
      category: 'Entrada',
      x: 0,
      y: 0,
      assetImage360: 'assets/E2.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'E1', yaw: -140, pitch: 12),
        HotspotLink(targetId: 'P1', yaw: 70, pitch: -10),
      ],
    ),
    MapLocation(
      id: 'P1',
      title: 'Pasillo 1',
      description: '',
      category: 'Pasillo',
      x: 0,
      y: 0,
      assetImage360: 'assets/P1.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'P3', yaw: -160, pitch: -10),
        HotspotLink(targetId: 'E2', yaw: 0, pitch: -12),
      ],
    ),
    MapLocation(
      id: 'P2',
      title: 'Pasillo 2',
      description: '',
      category: 'Pasillo',
      x: 0,
      y: 0,
      assetImage360: 'assets/P2.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'E1', yaw: -90, pitch: -13),
        HotspotLink(targetId: 'S3', yaw: 40, pitch: -15),
      ],
    ),
    MapLocation(
      id: 'P3',
      title: 'Pasillo Central',
      description: '',
      category: 'Pasillo',
      x: 0,
      y: 0,
      assetImage360: 'assets/P3.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'P1', yaw: 20, pitch: -10),
        HotspotLink(targetId: 'S2', yaw: -140, pitch: -13),
      ],
    ),
    MapLocation(
      id: 'S2',
      title: 'Lab. Software (S2)',
      description: '',
      category: 'Laboratorio',
      x: 0,
      y: 0,
      assetImage360: 'assets/S2.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'S1', yaw: 50, pitch: -15),
        HotspotLink(targetId: 'P3', yaw: -170, pitch: -10),
      ],
    ),
    MapLocation(
      id: 'S1',
      title: 'Lab. Redes (S1)',
      description: '',
      category: 'Laboratorio',
      x: 0,
      y: 0,
      assetImage360: 'assets/S1.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'S2', yaw: -30, pitch: -12),
        HotspotLink(targetId: 'S3', yaw: 110, pitch: -15),
      ],
    ),
    MapLocation(
      id: 'S3',
      title: 'Lab. Electrónica (S3)',
      description: '',
      category: 'Laboratorio',
      x: 0,
      y: 0,
      assetImage360: 'assets/S3.jpg',
      hotspotLinks: [
        HotspotLink(targetId: 'P2', yaw: -60, pitch: -10),
        HotspotLink(targetId: 'S1', yaw: 150, pitch: -12),
      ],
    ),
  ];

  MapLocation? _selectedMapLocation;

  List<MapLocation> get mapPoints => _mapPoints;
  List<MapLocation> get tourPoints => _tourPoints;

  MapLocation? get selectedMapLocation => _selectedMapLocation;

  void selectMapLocation(MapLocation? location) {
    _selectedMapLocation = location;
    notifyListeners();
  }

  MapLocation getTourLocationById(String id) {
    return _tourPoints.firstWhere(
      (loc) => loc.id == id,
      orElse: () => _tourPoints.first,
    );
  }
}
