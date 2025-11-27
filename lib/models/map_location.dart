import 'package:flutter/material.dart';

class MapLocation {
  final String id;
  String title;
  String description;
  String category;
  double x;
  double y;
  String assetImage360;
  IconData icon;
  String features;
  List<String> equipmentImages;
  
  // NUEVO: Lista de IDs de otras ubicaciones a las que se puede ir desde aquí
  // Ejemplo: Desde P1 puedes ir a S1 y S2.
  List<String> linkedIds; 

  MapLocation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.x,
    required this.y,
    required this.assetImage360,
    this.icon = Icons.place,
    this.features = "• Acceso Controlado\n• Aire Acondicionado",
    this.equipmentImages = const [],
    this.linkedIds = const [],
  });

  // Método copyWith actualizado
  MapLocation copyWith({
    String? title,
    String? description,
    String? category,
    double? x,
    double? y,
    String? assetImage360,
    IconData? icon,
    String? features,
    List<String>? equipmentImages,
    List<String>? linkedIds,
  }) {
    return MapLocation(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      x: x ?? this.x,
      y: y ?? this.y,
      assetImage360: assetImage360 ?? this.assetImage360,
      icon: icon ?? this.icon,
      features: features ?? this.features,
      equipmentImages: equipmentImages ?? this.equipmentImages,
      linkedIds: linkedIds ?? this.linkedIds,
    );
  }
}