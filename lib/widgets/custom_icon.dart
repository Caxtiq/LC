import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';
import 'package:flutterswing/states/page_state.dart';
import 'package:provider/provider.dart';

class CustomIcon extends StatelessWidget {
  final CanvasComponent component;

  const CustomIcon({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = component.size.width;
    final Color color = Color(component.properties['color'] ?? 0xFF000000);
    final String iconName = component.properties['iconName'] ?? 'error';
    final double borderRadius = component.properties['borderRadius']?.toDouble() ?? 8.0;
    final bool hasShadow = component.properties['hasShadow'] ?? false;
    final bool hasBackground = component.properties['hasBackground'] ?? false;
    final Color backgroundColor = Color(component.properties['backgroundColor'] ?? 0xFFFFFFFF);
    final String? action = component.properties['action'];
    final String? navigateTo = component.properties['navigateTo'];

    Widget iconWidget = Icon(
      _getIconData(iconName),
      size: size,
      color: color,
    );

    if (action != null) {
      iconWidget = InkWell(
        onTap: () {
          if (action == 'navigate' && navigateTo != null) {
            final pageState = Provider.of<PageState>(context, listen: false);
            pageState.setCurrentPage(navigateTo);
          }
          //more actions
        },
        child: iconWidget,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: hasBackground ? backgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                )
              ]
            : null,
      ),
      child: iconWidget,
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