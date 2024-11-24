import 'package:flutter/material.dart';
import 'package:flutterswing/tile/draggable_component_tile.dart';

import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: ListView(
        children: [
          _buildCategory('Basic Widgets', [
            'Text',
            'Button',
            'TextField',
            'Image',
            'Icon',
            'Container',
          ]),
          _buildCategory('Layout Widgets', [
            'Row',
            'Column',
            'Stack',
          ]),
          _buildCategory('Input Widgets', [
            'Checkbox',
            'Radio',
            'Switch',
            'Slider',
          ]),
          _buildCategory('Content Widgets', [
            'ListView',
            'GridView',
          ]),
        ],
      ),
    );
  }

  Widget _buildCategory(String title, List<String> items) {
    return ExpansionTile(
      title: Text(title),
      children: items.map((item) => _buildDraggableItem(item)).toList(),
    );
  }

  Widget _buildDraggableItem(String type) {
    return Draggable<String>(
      data: type,
      child: ListTile(
        leading: Icon(_getIconForType(type)),
        title: Text(type),
      ),
      feedback: Material(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.blue[100],
          child: Text(type),
        ),
      ),
      childWhenDragging: ListTile(
        leading: Icon(_getIconForType(type)),
        title: Text(type),
        enabled: false,
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'Text':
        return Icons.text_fields;
      case 'Button':
        return Icons.smart_button;
      case 'TextField':
        return Icons.input;
      case 'Image':
        return Icons.image;
      case 'Icon':
        return Icons.emoji_symbols;
      case 'Container':
        return Icons.check_box_outline_blank;
      case 'Row':
        return Icons.view_week;
      case 'Column':
        return Icons.view_agenda;
      case 'Stack':
        return Icons.layers;
      case 'Checkbox':
        return Icons.check_box;
      case 'Radio':
        return Icons.radio_button_checked;
      case 'Switch':
        return Icons.toggle_on;
      case 'Slider':
        return Icons.linear_scale;
      case 'ListView':
        return Icons.list;
      case 'GridView':
        return Icons.grid_on;
      default:
        return Icons.widgets;
    }
  }
}