import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomText extends StatelessWidget {
  final CanvasComponent component;

  const CustomText({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textAlign = _getTextAlign(component.properties['textAlign']);
    final overflow = _getTextOverflow(component.properties['overflow']);

    return Text(
      component.properties['text'] ?? 'Sample Text',
      style: TextStyle(
        fontSize: component.properties['fontSize'] ?? 16.0,
        fontWeight: _getFontWeight(component.properties['fontWeight']),
        fontStyle: component.properties['isItalic'] == true ? FontStyle.italic : FontStyle.normal,
        color: Color(component.properties['color'] ?? 0xFF000000),
        letterSpacing: component.properties['letterSpacing'] ?? 0.0,
        height: component.properties['lineHeight'],
        decoration: _getTextDecoration(component.properties['decoration']),
        decorationColor: Color(component.properties['decorationColor'] ?? 0xFF000000),
        decorationStyle: _getDecorationStyle(component.properties['decorationStyle']),
        fontFamily: component.properties['fontFamily'],
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: component.properties['maxLines'],
      softWrap: component.properties['softWrap'] ?? true,
    );
  }

  FontWeight _getFontWeight(dynamic weight) {
    if (weight is int) {
      return FontWeight.values.firstWhere((w) => w.index == weight, orElse: () => FontWeight.normal);
    }
    return FontWeight.normal;
  }

  TextAlign _getTextAlign(String? align) {
    switch (align) {
      case 'left':
        return TextAlign.left;
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      default:
        return TextAlign.start;
    }
  }

  TextOverflow _getTextOverflow(String? overflow) {
    switch (overflow) {
      case 'ellipsis':
        return TextOverflow.ellipsis;
      case 'fade':
        return TextOverflow.fade;
      case 'visible':
        return TextOverflow.visible;
      default:
        return TextOverflow.clip;
    }
  }

  TextDecoration _getTextDecoration(String? decoration) {
    switch (decoration) {
      case 'underline':
        return TextDecoration.underline;
      case 'overline':
        return TextDecoration.overline;
      case 'lineThrough':
        return TextDecoration.lineThrough;
      default:
        return TextDecoration.none;
    }
  }

  TextDecorationStyle _getDecorationStyle(String? style) {
    switch (style) {
      case 'dashed':
        return TextDecorationStyle.dashed;
      case 'dotted':
        return TextDecorationStyle.dotted;
      case 'double':
        return TextDecorationStyle.double;
      case 'wavy':
        return TextDecorationStyle.wavy;
      default:
        return TextDecorationStyle.solid;
    }
  }
}