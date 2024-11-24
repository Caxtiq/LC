import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomTextField extends StatelessWidget {
  final CanvasComponent component;

  const CustomTextField({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: component.size.width,
      height: component.size.height,
      child: TextField(
        decoration: InputDecoration(
          hintText: component.properties['hintText'] ?? 'Enter text',
          labelText: component.properties['labelText'] ?? 'Label',
          border: _getBorder(),
          filled: component.properties['filled'] ?? false,
          fillColor: Color(component.properties['fillColor'] ?? 0xFFFFFFFF),
        ),
        style: TextStyle(
          fontSize: component.properties['fontSize'] ?? 16.0,
          color: Color(component.properties['textColor'] ?? 0xFF000000),
        ),
        obscureText: component.properties['obscureText'] ?? false,
        maxLines: component.properties['maxLines'] ?? 1,
        keyboardType: _getKeyboardType(),
      ),
    );
  }

  InputBorder _getBorder() {
    final borderType = component.properties['borderType'] ?? 'outline';
    final borderColor = Color(component.properties['borderColor'] ?? 0xFF000000);
    final borderRadius = BorderRadius.circular(component.properties['borderRadius'] ?? 8.0);

    switch (borderType) {
      case 'outline':
        return OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        );
      case 'underline':
        return UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        );
      case 'none':
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: borderColor),
        );
    }
  }

  TextInputType _getKeyboardType() {
    final inputType = component.properties['keyboardType'] ?? 'text';
    switch (inputType) {
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'email':
        return TextInputType.emailAddress;
      case 'multiline':
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }
}