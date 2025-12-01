import 'package:flutter/material.dart';

// Clase para definir flechas de navegación con posición exacta
class HotspotLink {
  final String targetId;
  final double yaw;   // Posición horizontal (grados)
  final double pitch; // Posición vertical (grados)

  HotspotLink({
    required this.targetId,
    this.yaw = 0.0,
    this.pitch = 0.0,
  });
}

// Clases para información detallada del edificio
class LabInfo {
  final String name;
  final String description;
  final String inCharge;
  final String contact;
  final String imageThumbnail;
  final String? asset360;

  LabInfo({
    required this.name,
    required this.description,
    required this.inCharge,
    required this.contact,
    required this.imageThumbnail,
    this.asset360,
  });
}

class CareerInfo {
  final String name;
  final List<LabInfo> labs;

  CareerInfo({required this.name, required this.labs});
}

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
  
  // Usamos hotspotLinks para navegación precisa
  List<HotspotLink> hotspotLinks; 
  
  // Información extra para edificios (Carreras)
  List<CareerInfo> careers;

  MapLocation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.x,
    required this.y,
    required this.assetImage360,
    this.icon = Icons.place,
    this.features = "• Acceso Controlado",
    this.equipmentImages = const [],
    this.hotspotLinks = const [],
    this.careers = const [],
  });

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
    List<HotspotLink>? hotspotLinks,
    List<CareerInfo>? careers,
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
      hotspotLinks: hotspotLinks ?? this.hotspotLinks,
      careers: careers ?? this.careers,
    );
  }
}