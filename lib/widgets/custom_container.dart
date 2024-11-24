import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomContainer extends StatelessWidget {
  final CanvasComponent component;

  const CustomContainer({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Color(component.properties['color'] ?? 0xFFE0E0E0);
    final double borderRadius = component.properties['borderRadius']?.toDouble() ?? 8.0;
    final bool hasShadow = component.properties['hasShadow'] ?? false;

    return Container(
      width: component.size.width,
      height: component.size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]
            : null,
      ),
    );
  }
}