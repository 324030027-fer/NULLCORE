import 'package:flutter/material.dart';
import '../models/map_location.dart';

class MapProvider extends ChangeNotifier {
  
  // --- LISTA 1: PUNTOS PARA EL MAPA AÉREO (Información) ---
  final List<MapLocation> _mapPoints = [
    MapLocation(
      id: 'RECTORIA', title: 'RECTORÍA',
      description: 'Es el edificio que alberga a las máximas autoridades y la administración central de la universidad. Es el centro de las decisiones estratégicas.',
      category: 'Administración', x: 0.1016, y: 0.3836, assetImage360: '', icon: Icons.account_balance,
      features: "• Oficinas del Rector: Despacho de la figura directiva principal.\n\n• Direcciones y Coordinaciones: Oficinas de áreas clave como la Secretaría Académica, Administración y Finanzas.\n\n• Área de planeación: Espacios donde se diseñan y gestionan los planes de estudio y el desarrollo institucional.",
      equipmentImages:  ['assets/rectoria1.jpg','assets/EDIFICIOSRECT.jpg']
    ),
    MapLocation(
      id: 'BIBLIOTECA', title: 'BIBLIOTECA',
      description: 'Es el centro de recursos de información académica y de investigación de la universidad.',
      category: 'Estudio', x: 0.1195, y: 0.2830, assetImage360: '', icon: Icons.local_library,
      features: "• Acervo bibliográfico: Colección de libros, revistas, tesis y material de consulta impreso\n\n• Área digital: Acceso a bases de datos en línea, e-books y computadoras con internet.\n\n• Préstamo de material: Servicio para llevar libros a casa o consultar en sala.  ", 
      equipmentImages:  ['assets/biblio1.png','assets/EDIFICIOSRECT.jpg']
    ),
    MapLocation(
      id: 'UD2', title: 'UD2 (UNIDAD DE DOCENCIA 2)',
      description: 'Similar a la UD1, es otro edificio fundamental para la enseñanza, pero a menudo está más enfocado en laboratorios y prácticas especializadas de las ingenierías y carreras técnicas.',
      category: 'Docencia', x: 0.2332, y: 0.8767, assetImage360: '', icon: Icons.class_outlined,
      features: "• Aulas/Salones de clase: Para clases teóricas y seminarios.\n\n• Laboratorios especializados: Espacios equipados con maquinaria, herramientas e instrumentos para la realización de prácticas, experimentos y proyectos (ej. laboratorios de electrónica, mecánica, química, etc., dependiendo de la oferta académica).\n\n• Espacios de trabajo: Áreas para el desarrollo de proyectos de investigación aplicada por parte de estudiantes y profesores.",
      equipmentImages:  ['assets/UD2.jpg', 'assets/UD21.jpg']
    ),
    MapLocation(
      id: 'UD1', title: 'UD1 (UNIDAD DE DOCENCIA 1)',
      description: 'Es uno de los principales edificios dedicados a la enseñanza teórica y la actividad académica cotidiana.',
      category: 'Docencia', x: 0.7996, y: 0.5377, assetImage360: '', icon: Icons.school,
      features: "• Aulas/Salones de clase: Espacios equipados con proyectores y pizarrones para la impartición de clases teóricas.\n\n• Cubículos: Oficinas designadas para profesores donde atienden a estudiantes y preparan sus clases.\n\n• Salas de cómputo: Laboratorios equipados con computadoras para asignaturas que requieren software especializado.",
      equipmentImages:  ['assets/UD1.png','assets/UD1_IN.jpg']
    ),
    MapLocation(
      id: 'CAFETERIA', title: 'CAFETERÍA',
      description: 'Es el espacio destinado a la alimentación y descanso de la comunidad universitaria (estudiantes, docentes y personal administrativo).',
      category: 'Servicios', x: 0.5999, y: 0.3271, assetImage360: '', icon: Icons.restaurant,
      features: ("• Área de servicio: Puntos de venta para comidas completas, refrigerios y bebidas.\n\n • Comedor: Mesas y sillas para consumir alimentos.\n\n• Socialización: Un punto de encuentro y convivencia."),
      equipmentImages:  ['assets/CAFE11.jpg','assets/CAFEPRIN.jpg']
    ),
    MapLocation(
      id: 'CANCHA', title: 'CANCHA DE USOS MÚLTIPLES',
      description: 'Es un espacio al aire libre o techado diseñado para la práctica de diversas disciplinas deportivas y eventos recreativos.',
      category: 'Deportes', x: 0.3594, y: 0.3046, assetImage360: '', icon: Icons.sports_basketball,
      features: "• Demarcación: Líneas y señalizaciones para deportes como baloncesto, voleibol y fútbol sala.\n\n• Gradas: Asientos para espectadores.\n\n• Actividades: Se utiliza para clases de educación física, torneos, actos cívicos y eventos culturales.",
      equipmentImages:  ['assets/CANCHA1.png', 'assets/CANCHA2.jpg']
    ),
    
    // --- LT MAPA (CON DETALLES DE CARRERAS) ---
    MapLocation(
      id: 'LT_MAP', title: 'LT (LABORATORIOS)',
      description: 'Edificio central de laboratorios de alta tecnología.',
      category: 'Laboratorio', x: 0.8000, y: 0.1365, assetImage360: '', icon: Icons.science,
      features: "• Acceso biométrico\n• Videovigilancia 24/7",
      equipmentImages: ['assets/LT1.jpg', 'assets/LT12.jpg'],
      careers: [
        CareerInfo(
          name: "ING. REDES Y TELECOMUNICACIONES / TI",
          labs: [
            LabInfo(
              name: "LAB. DE REDES",
              description: "Configuración de dispositivos de red, routing y switching.",
              inCharge: "Ing. Erick Fernando Montecillo Olivares",
              contact: "emontecillo@upjr.edu.mx",
              imageThumbnail: "assets/redes.jpg", 
              asset360: null, // No tiene 360
            ),
            LabInfo(
              name: "LAB. DE ELECTRÓNICA",
              description: "Equipado con osciloscopios y estaciones de soldadura.",
              inCharge: "Ing. Erick Fernando Montecillo Olivares",
              contact: "emontecillo@upjr.edu.mx",
              imageThumbnail: "assets/pano_electronica.jpg", 
              asset360: "assets/pano_electronica.jpg",
            ),
            LabInfo(
              name: "LAB. DE TELEMÁTICA",
              description: "Laboratorio de las carreras de Ing. en Redes y Telecomunicaciones / Ing. en Tecnologías de la Información, cuenta con 28 estaciones de trabajo y equipos de cómputo.",
              inCharge: "Ing. Erick Fernando Montecillo Olivares",
              contact: "emontecillo@upjr.edu.mx",
              imageThumbnail: "assets/pano_telematica.jpg", 
              asset360: "assets/pano_telematica.jpg",
            ),
          ]
        ),
      ]
    ),
  ];

  // --- LISTA 2: PUNTOS PARA EL RECORRIDO VIRTUAL (Con Hotspots) ---
  final List<MapLocation> _tourPoints = [
    MapLocation(
      id: 'E1', title: 'Entrada Trasera', description: '', category: 'Entrada', x: 0, y: 0, 
      assetImage360: 'assets/E1.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'E2', yaw: 93), HotspotLink(targetId: 'E3', yaw: -87)],
    ),
    MapLocation(
      id: 'E2', title: 'Esquina Derecha', description: '', category: 'Esquina', x: 0, y: 0, 
      assetImage360: 'assets/E2.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'P1', yaw: 45), HotspotLink(targetId: 'E1', yaw: -45)],
    ),
    MapLocation(
      id: 'P1', title: 'Pasillo 1', description: '', category: 'Pasillo', x: 0, y: 0, 
      assetImage360: 'assets/P1.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'P3', yaw: 140), HotspotLink(targetId: 'E2', yaw: -85)],
    ),
    MapLocation(
      id: 'P3', title: 'Pasillo Central', description: '', category: 'Pasillo', x: 0, y: 0, 
      assetImage360: 'assets/P3.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'BH', yaw: 0), HotspotLink(targetId: 'P1', yaw: 180)],
    ),
    MapLocation(
      id: 'BH', title: 'Baños Hombres', description: '', category: 'Baños H', x: 0, y: 0, 
      assetImage360: 'assets/S2.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'EP', yaw: 37), HotspotLink(targetId: 'P3', yaw: -55)],
    ),
    MapLocation(
      id: 'EP', title: 'Entrada Principal', description: '', category: 'Entrada', x: 0, y: 0, 
      assetImage360: 'assets/S1.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'BM', yaw: 90), HotspotLink(targetId: 'BH', yaw: -85)],
    ),
        MapLocation(
      id: 'BM', title: 'Baños Mujeres', description: '', category: 'Baños M', x: 0, y: 0, 
      assetImage360: 'assets/S3.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'P2', yaw: 45), HotspotLink(targetId: 'EP', yaw: -45)],
    ),
     MapLocation(
      id: 'P4', title: 'Pasillo 4', description: '', category: 'Pasillo', x: 0, y: 0, 
      assetImage360: 'assets/P4.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'P2', yaw: 90), HotspotLink(targetId: 'BM', yaw: -90)],
    ),
    MapLocation(
      id: 'P2', title: 'Pasillo 2', description: '', category: 'Pasillo', x: 0, y: 0, 
      assetImage360: 'assets/P2.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'E3', yaw: 90), HotspotLink(targetId: 'P4', yaw: -90), HotspotLink(targetId: 'LT', yaw: -110)],
    ),
         MapLocation(
      id: 'E3', title: 'Esquina Izquierda', description: '', category: 'Esquina', x: 0, y: 0, 
      assetImage360: 'assets/E3.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'E1', yaw: 42), HotspotLink(targetId: 'P2', yaw: -45)],
    ),
    MapLocation(
      id: 'LT', title: 'LAB TELEMATICA', description: '', category: 'Edificio', x: 0, y: 0, 
      assetImage360: 'assets/pano_telematica.jpg', 
      hotspotLinks: [HotspotLink(targetId: 'P2', yaw: -45)],
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
    return _tourPoints.firstWhere((loc) => loc.id == id, orElse: () => _tourPoints.first);
  }

  // Métodos Admin
  void addMapPoint(MapLocation location) { _mapPoints.add(location); notifyListeners(); }
  void updateMapPoint(MapLocation location) {
    final index = _mapPoints.indexWhere((l) => l.id == location.id);
    if(index != -1) { _mapPoints[index] = location; notifyListeners(); }
  }
  void removeMapPoint(String id) {
    _mapPoints.removeWhere((l) => l.id == id);
    if (_selectedMapLocation?.id == id) _selectedMapLocation = null;
    notifyListeners();
  }
}