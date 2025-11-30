import 'package:flutter/material.dart';

class HotspotLink {
  final String targetId;
  final double yaw;
  final double pitch;

  HotspotLink({
    required this.targetId,
    this.yaw = 0.0,
    this.pitch = 0.0,
  });
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

  /// Lista de vínculos hacia otras ubicaciones, con coordenadas exactas para hotspots
  List<HotspotLink> hotspotLinks;

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
    this.hotspotLinks = const [],
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
    );
  }
}
