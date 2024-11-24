import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomContainer extends StatelessWidget {
  final CanvasComponent component;

  const CustomContainer({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = _getColor(component.properties['color']);
    final double borderRadius = _getBorderRadius(component.properties['borderRadius']);
    final bool hasShadow = _getHasShadow(component.properties['hasShadow']);
    final EdgeInsetsGeometry padding = _getPadding(component.properties['padding']);
    final EdgeInsetsGeometry margin = _getMargin(component.properties['margin']);
    final List<Widget> children = _getChildren(component);

    return Container(
      width: component.size.width,
      height: component.size.height,
      padding: padding,
      margin: margin,
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
      child: children.isEmpty
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
    );
  }

  Color _getColor(dynamic colorValue) {
    return colorValue is String
        ? Color(int.parse(colorValue, radix: 16)).withOpacity(1.0)
        : Colors.transparent;
  }

  double _getBorderRadius(dynamic radiusValue) {
    return (radiusValue is num) ? radiusValue.toDouble() : 8.0;
  }

  bool _getHasShadow(dynamic shadowValue) {
    return shadowValue is bool ? shadowValue : false;
  }

  EdgeInsetsGeometry _getPadding(dynamic paddingValue) {
    if (paddingValue is List && paddingValue.length == 4) {
      return EdgeInsets.fromLTRB(
        paddingValue[0]?.toDouble() ?? 0.0,
        paddingValue[1]?.toDouble() ?? 0.0,
        paddingValue[2]?.toDouble() ?? 0.0,
        paddingValue[3]?.toDouble() ?? 0.0,
      );
    }
    return EdgeInsets.zero;
  }

  EdgeInsetsGeometry _getMargin(dynamic marginValue) {
    if (marginValue is List && marginValue.length == 4) {
      return EdgeInsets.fromLTRB(
        marginValue[0]?.toDouble() ?? 0.0,
        marginValue[1]?.toDouble() ?? 0.0,
        marginValue[2]?.toDouble() ?? 0.0,
        marginValue[3]?.toDouble() ?? 0.0,
      );
    }
    return EdgeInsets.zero;
  }

  List<Widget> _getChildren(CanvasComponent component) {
    return component.children
        .map((childComponent) => CustomContainer(component: childComponent))
        .toList();
  }
}
