import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';
import 'package:uuid/uuid.dart';

class CanvasState extends ChangeNotifier {
  Map<String, List<CanvasComponent>> pageComponents = {'home': []};
  final uuid = Uuid();

  void addComponent(String pageId, String type, Offset position) {
    final component = CanvasComponent(
      id: uuid.v4(),
      type: type,
      position: position,
      size: _getDefaultSize(type),
      properties: _getDefaultProperties(type),
    );
    if (!pageComponents.containsKey(pageId)) {
      pageComponents[pageId] = [];
    }
    pageComponents[pageId]!.add(component);
    notifyListeners();
  }

  Size _getDefaultSize(String type) {
    switch (type) {
      case 'Text':
        return Size(200, 50);
      case 'Button':
        return Size(150, 50);
      case 'TextField':
        return Size(250, 60);
      case 'Image':
        return Size(250, 250);
      case 'Icon':
        return Size(48, 48);
      case 'Container':
        return Size(300, 200);
      default:
        return Size(150, 50);
    }
  }

  Map<String, dynamic> _getDefaultProperties(String type) {
    switch (type) {
      case 'Text':
        return {
          'text': 'Sample Text',
          'fontSize': 18.0,
          'color': 0xFF000000,
        };
      case 'Button':
        return {
          'text': 'Button',
          'action': 'none',
          'backgroundColor': 0xFF2196F3,
          'textColor': 0xFFFFFFFF,
          'borderRadius': 8.0,
          'iconName': null,
          'isIconLeading': true,
        };
      case 'TextField':
        return {
          'hintText': 'Enter text',
          'labelText': 'Label',
          'borderType': 'outline',
          'borderRadius': 8.0,
          'borderColor': 0xFF000000,
          'filled': false,
          'fillColor': 0xFFFFFFFF,
          'keyboardType': 'text',
          'obscureText': false,
          'maxLines': 1,
          'textColor': 0xFF000000,
          'fontSize': 16.0,
        };
      case 'Image':
        return {
          'imageUrl': '',
          'fit': 'cover',
          'borderRadius': 8.0,
          'hasShadow': false,
        };
      case 'Icon':
        return {
          'iconName': 'error',
          'color': 0xFF000000,
          'hasBackground': false,
          'backgroundColor': 0xFFFFFFFF,
          'borderRadius': 8.0,
          'hasShadow': false,
          'action': null,
          'navigateTo': null,
        };
      case 'Container':
        return {
          'color': 0xFFE0E0E0,
          'borderRadius': 8.0,
          'hasShadow': false,
        };
      default:
        return {};
    }
  }





  void updateComponentPosition(String pageId, String id, Offset newPosition) {
    final components = pageComponents[pageId];
    if (components != null) {
      final index = components.indexWhere((component) => component.id == id);
      if (index != -1) {
        components[index] = components[index].copyWith(position: newPosition);
        notifyListeners();
        print('Updated position of component: $id');
      }
    }
  }

  void updateComponentSize(String pageId, String id, Size newSize) {
    final components = pageComponents[pageId];
    if (components != null) {
      final index = components.indexWhere((component) => component.id == id);
      if (index != -1) {
        components[index] = components[index].copyWith(size: newSize);
        notifyListeners();
        print('Updated size of component: $id');
      }
    }
  }

  void updateComponentProperties(String pageId, String id, Map<String, dynamic> newProperties) {
    final components = pageComponents[pageId];
    if (components != null) {
      final index = components.indexWhere((component) => component.id == id);
      if (index != -1) {
        final updatedProperties = {...components[index].properties, ...newProperties};
        components[index] = components[index].copyWith(properties: updatedProperties);
        notifyListeners();
        print('Updated properties of component: $id');
        print('New properties: $updatedProperties');
      }
    }
  }

  void removeComponent(String pageId, String id) {
    pageComponents[pageId]?.removeWhere((component) => component.id == id);
    notifyListeners();
    print('Removed component: $id from page: $pageId');
  }
}