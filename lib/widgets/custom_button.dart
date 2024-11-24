import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomButton extends StatelessWidget {
  final CanvasComponent component;

  const CustomButton({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String text = component.properties['text'] ?? 'Button';
    final Color backgroundColor = Color(component.properties['backgroundColor'] ?? 0xFF2196F3);
    final Color textColor = Color(component.properties['textColor'] ?? 0xFFFFFFFF);
    final double borderRadius = component.properties['borderRadius'] ?? 8.0;
    final String? iconName = component.properties['iconName'];
    final bool isIconLeading = component.properties['isIconLeading'] ?? true;

    Widget buttonContent = Text(
      text,
      style: TextStyle(color: textColor, fontSize: 16),
    );

    if (iconName != null) {
      final icon = Icon(_getIconData(iconName), color: textColor);
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: isIconLeading
            ? [icon, SizedBox(width: 8), buttonContent]
            : [buttonContent, SizedBox(width: 8), icon],
      );
    }

    return SizedBox(
      width: component.size.width,
      height: component.size.height,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: buttonContent,
      ),
    );
  }


  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'add':
        return Icons.add;
      case 'delete':
        return Icons.delete;
      case 'edit':
        return Icons.edit;
      case 'favorite':
        return Icons.favorite;
      case 'search':
        return Icons.search;
      case 'settings':
        return Icons.settings;
      case 'share':
        return Icons.share;
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      case 'shopping_cart':
        return Icons.shopping_cart;
      default:
        return Icons.error;
    }
  }
}
