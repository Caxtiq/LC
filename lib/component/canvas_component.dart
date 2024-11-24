import 'dart:ui';

import 'package:flutter/material.dart';

class CanvasComponent {
  final String id;
  final String type;
  final Offset position;
  late final Size size;
  final Map<String, dynamic> properties;
  final List<CanvasComponent> children; 

  CanvasComponent({
    required this.id,
    required this.type,
    required this.position,
    required this.size,
    this.properties = const {},
    this.children = const [], 
  });

  CanvasComponent copyWith({
    String? id,
    String? type,
    Offset? position,
    Size? size,
    Map<String, dynamic>? properties,
    List<CanvasComponent>? children, 
  }) {
    return CanvasComponent(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      size: size ?? this.size,
      properties: properties ?? Map.from(this.properties),
      children: children ?? List.from(this.children), 
    );
  }


  dynamic getProperty(String key, {dynamic defaultValue}) {
    return properties.containsKey(key) ? properties[key] : defaultValue;
  }

  void updateProperty(String key, dynamic value) {
    properties[key] = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'position': {'x': position.dx, 'y': position.dy},
      'size': {'width': size.width, 'height': size.height},
      'properties': properties,
      'children': children.map((child) => child.toJson()).toList(), // Chuyển children thành JSON
    };
  }

  static CanvasComponent fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List? ?? [];
    List<CanvasComponent> childrenList = childrenJson.map((childJson) => CanvasComponent.fromJson(childJson)).toList();
    
    return CanvasComponent(
      id: json['id'],
      type: json['type'],
      position: Offset(json['position']['x'], json['position']['y']),
      size: Size(json['size']['width'], json['size']['height']),
      properties: Map<String, dynamic>.from(json['properties'] ?? {}),
      children: childrenList, 
    );
  }
}
