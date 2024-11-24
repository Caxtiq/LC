import 'dart:ui';

import 'package:flutter/material.dart';

class CanvasComponent {
  final String id;
  final String type;
  final Offset position;
  final Size size;
  final Map<String, dynamic> properties;

  CanvasComponent({
    required this.id,
    required this.type,
    required this.position,
    required this.size,
    this.properties = const {},
  });

  CanvasComponent copyWith({
    String? id,
    String? type,
    Offset? position,
    Size? size,
    Map<String, dynamic>? properties,
  }) {
    return CanvasComponent(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      size: size ?? this.size,
      properties: properties ?? Map.from(this.properties),
    );
  }
}
