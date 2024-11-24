import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutterswing/component/canvas_component.dart';
import 'package:flutterswing/component/resizable_component.dart';
import 'package:flutterswing/states/canvas_state.dart';
import 'package:flutterswing/states/page_state.dart';
import 'package:flutterswing/widgets/custom_button.dart';
import 'package:flutterswing/widgets/custom_container.dart';
import 'package:flutterswing/widgets/custom_icon.dart';
import 'package:flutterswing/widgets/custom_image.dart';
import 'package:flutterswing/widgets/custom_text.dart';
import 'package:flutterswing/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';


class Canvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CanvasState, PageState>(
      builder: (context, canvasState, pageState, child) {
        final currentPageId = pageState.currentPageId;
        final components = canvasState.pageComponents[currentPageId] ?? [];

        return DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: [
                Container(
                  color: Colors.grey[200],
                  width: double.infinity,
                  height: double.infinity,
                ),
                ...components.map((component) {
                  return ResizableComponent(
                    key: ValueKey(component.id),
                    component: component,
                    onResize: (newSize) {
                      canvasState.updateComponentSize(currentPageId, component.id, newSize);
                    },
                    onMove: (newPosition) {
                      canvasState.updateComponentPosition(currentPageId, component.id, newPosition);
                    },
                    child: Stack(
                      children: [
                        _buildComponent(context, currentPageId, component),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: _buildComponentControls(context, currentPageId, component),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
          onAcceptWithDetails: (details) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.offset);
            canvasState.addComponent(currentPageId, details.data, localPosition);
          },
        );
      },
    );
  }

  Widget _buildComponent(BuildContext context, String pageId, CanvasComponent component) {
    switch (component.type) {
      case 'Text':
        return CustomText(component: component);
      case 'Button':
        return CustomButton(component: component);
      case 'TextField':
        return CustomTextField(component: component);
      case 'Image':
        return CustomImage(component: component);
      case 'Icon':
        return CustomIcon(component: component);
      case 'Container':
        return CustomContainer(component: component);
      default:
        return Container();
    }
  }

Widget _buildComponentControls(BuildContext context, String pageId, CanvasComponent component) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit, size: 16),
        onPressed: () {
          print('Edit button pressed for component: ${component.id}');
          _showEditDialog(context, pageId, component);
        },
        color: Colors.blue,
      ),
      IconButton(
        icon: Icon(Icons.delete, size: 16),
        onPressed: () => Provider.of<CanvasState>(context, listen: false).removeComponent(pageId, component.id),
        color: Colors.red,
      ),
    ],
  );
}

void _showEditDialog(BuildContext context, String pageId, CanvasComponent component) {
  print('Showing edit dialog for component: ${component.id} of type: ${component.type}');
  print('Component properties: ${component.properties}');
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit ${component.type}'),
        content: SingleChildScrollView(
          child: _buildEditForm(context, pageId, component),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Widget _buildEditForm(BuildContext context, String pageId, CanvasComponent component) {
  switch (component.type) {
    case 'TextField':
      return _buildTextFieldEditForm(context, pageId, component);
    case 'Button':
      return _buildButtonEditForm(context, pageId, component);
    // case 'Text':
    //   return _buildTextEditForm(context, pageId, component);
     case 'Image':
      return _buildImageEditForm(context, pageId, component);
     case 'Icon':
      return _buildIconEditForm(context, pageId, component);
    // case 'Container':
    //   return _buildContainerEditForm(context, pageId, component);
    default:
      return Container(child: Text('No edit form available for this component type.'));
  }
}
  Widget _buildIconEditForm(BuildContext context, String pageId, CanvasComponent component) {
    final canvasState = Provider.of<CanvasState>(context, listen: false);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: component.properties['iconName'] ?? 'error',
                decoration: InputDecoration(labelText: 'Icon'),
                items: [
                  'add', 'delete', 'edit', 'favorite', 'search', 'settings',
                  'share', 'home', 'person', 'shopping_cart', 'error'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(_getIconData(value)),
                        SizedBox(width: 10),
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    canvasState.updateComponentProperties(pageId, component.id, {'iconName': value});
                  }
                },
              ),
              SizedBox(height: 20),
              Text('Icon Preview:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Center(
                child: Icon(
                  _getIconData(component.properties['iconName'] ?? 'error'),
                  size: 50,
                  color: Color(component.properties['color'] ?? 0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final Color? color = await showColorPicker(
                    context,
                    component.properties['color'] ?? 0xFF000000,
                  );
                  if (color != null) {
                    canvasState.updateComponentProperties(pageId, component.id, {'color': color.value});
                  }
                },
                child: Text('Change Icon Color'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: component.size.width.toString(),
                decoration: InputDecoration(labelText: 'Icon Size'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final size = double.tryParse(value);
                  if (size != null) {
                    canvasState.updateComponentSize(pageId, component.id, Size(size, size));
                  }
                },
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Has Background'),
                value: component.properties['hasBackground'] ?? false,
                onChanged: (value) {
                  setState(() {
                    canvasState.updateComponentProperties(pageId, component.id, {'hasBackground': value});
                  });
                },
              ),
              if (component.properties['hasBackground'] ?? false) ...[
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final Color? color = await showColorPicker(
                      context,
                      component.properties['backgroundColor'] ?? 0xFFFFFFFF,
                    );
                    if (color != null) {
                      canvasState.updateComponentProperties(pageId, component.id, {'backgroundColor': color.value});
                    }
                  },
                  child: Text('Change Background Color'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: (component.properties['borderRadius'] ?? 0).toString(),
                  decoration: InputDecoration(labelText: 'Border Radius'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(pageId, component.id, {'borderRadius': double.tryParse(value)});
                  },
                ),
              ],
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Has Shadow'),
                value: component.properties['hasShadow'] ?? false,
                onChanged: (value) {
                  setState(() {
                    canvasState.updateComponentProperties(pageId, component.id, {'hasShadow': value});
                  });
                },
              ),
            ],
          ),
        );
      },
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


Widget _buildTextFieldEditForm(BuildContext context, String pageId, CanvasComponent component) {
  final canvasState = Provider.of<CanvasState>(context, listen: false);

  return Container(
    width: 300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            initialValue: component.properties['hintText'] ?? 'Enter text',
            decoration: InputDecoration(
              labelText: 'Hint Text',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              canvasState.updateComponentProperties(
                pageId, 
                component.id, 
                {'hintText': value}
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            initialValue: component.properties['labelText'] ?? '',
            decoration: InputDecoration(
              labelText: 'Label Text',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              canvasState.updateComponentProperties(
                pageId, 
                component.id, 
                {'labelText': value}
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonFormField<String>(
            value: component.properties['borderType'] ?? 'outline',
            decoration: InputDecoration(
              labelText: 'Border Style',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'outline', child: Text('Outline')),
              DropdownMenuItem(value: 'underline', child: Text('Underline')),
              DropdownMenuItem(value: 'none', child: Text('None')),
            ],
            onChanged: (value) {
              if (value != null) {
                canvasState.updateComponentProperties(
                  pageId, 
                  component.id, 
                  {'borderType': value}
                );
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DropdownButtonFormField<String>(
            value: component.properties['keyboardType'] ?? 'text',
            decoration: InputDecoration(
              labelText: 'Keyboard Type',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'text', child: Text('Text')),
              DropdownMenuItem(value: 'number', child: Text('Number')),
              DropdownMenuItem(value: 'email', child: Text('Email')),
              DropdownMenuItem(value: 'phone', child: Text('Phone')),
              DropdownMenuItem(value: 'multiline', child: Text('Multiline')),
            ],
            onChanged: (value) {
              if (value != null) {
                canvasState.updateComponentProperties(
                  pageId, 
                  component.id, 
                  {'keyboardType': value}
                );
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: (component.properties['fontSize'] ?? 16.0).toString(),
                  decoration: InputDecoration(
                    labelText: 'Font Size',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(
                      pageId, 
                      component.id, 
                      {'fontSize': double.tryParse(value) ?? 16.0}
                    );
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  initialValue: (component.properties['maxLines'] ?? 1).toString(),
                  decoration: InputDecoration(
                    labelText: 'Max Lines',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(
                      pageId, 
                      component.id, 
                      {'maxLines': int.tryParse(value) ?? 1}
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text('Obscure Text'),
                  value: component.properties['obscureText'] ?? false,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(
                      pageId, 
                      component.id, 
                      {'obscureText': value}
                    );
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text('Filled'),
                  value: component.properties['filled'] ?? false,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(
                      pageId, 
                      component.id, 
                      {'filled': value}
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.color_lens),
                  label: Text('Text Color'),
                  onPressed: () async {
                    final Color? color = await showColorPicker(
                      context,
                      component.properties['textColor'] ?? 0xFF000000
                    );
                    if (color != null) {
                      canvasState.updateComponentProperties(
                        pageId,
                        component.id,
                        {'textColor': color.value}
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.border_color),
                  label: Text('Border Color'),
                  onPressed: () async {
                    final Color? color = await showColorPicker(
                      context,
                      component.properties['borderColor'] ?? 0xFF000000
                    );
                    if (color != null) {
                      canvasState.updateComponentProperties(
                        pageId,
                        component.id,
                        {'borderColor': color.value}
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        if (component.properties['filled'] == true)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton.icon(
              icon: Icon(Icons.format_color_fill),
              label: Text('Fill Color'),
              onPressed: () async {
                final Color? color = await showColorPicker(
                  context,
                  component.properties['fillColor'] ?? 0xFFFFFFFF
                );
                if (color != null) {
                  canvasState.updateComponentProperties(
                    pageId,
                    component.id,
                    {'fillColor': color.value}
                  );
                }
              },
            ),
          ),
      ],
    ),
  );
}
Widget _buildImageEditForm(BuildContext context, String pageId, CanvasComponent component) {
  final canvasState = Provider.of<CanvasState>(context, listen: false);
  final TextEditingController urlController = TextEditingController(text: component.properties['imageUrl'] ?? '');

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    urlController.clear();
                    canvasState.updateComponentProperties(pageId, component.id, {'imageUrl': ''});
                  },
                ),
              ),
              onChanged: (value) {
                canvasState.updateComponentProperties(pageId, component.id, {'imageUrl': value});
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text('Upload Image'),
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  String fileName = path.basename(image.path);
                  setState(() {
                    urlController.text = 'file://${image.path}';
                    canvasState.updateComponentProperties(pageId, component.id, {'imageUrl': 'file://${image.path}'});
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text('Image Preview:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: component.properties['imageUrl'] != null && component.properties['imageUrl']!.isNotEmpty
                ? component.properties['imageUrl']!.startsWith('file://')
                  ? Image.file(File(component.properties['imageUrl']!.replaceFirst('file://', '')), fit: BoxFit.cover)
                  : Image.network(component.properties['imageUrl']!, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 50, color: Colors.red))
                : Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: component.properties['width']?.toString() ?? '',
                    decoration: InputDecoration(labelText: 'Width'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      canvasState.updateComponentProperties(pageId, component.id, {'width': double.tryParse(value)});
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: component.properties['height']?.toString() ?? '',
                    decoration: InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      canvasState.updateComponentProperties(pageId, component.id, {'height': double.tryParse(value)});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: component.properties['fit'] ?? 'cover',
              decoration: InputDecoration(labelText: 'Fit'),
              items: ['cover', 'contain', 'fill', 'fitWidth', 'fitHeight', 'none', 'scaleDown']
                  .map((fit) => DropdownMenuItem(value: fit, child: Text(fit)))
                  .toList(),
              onChanged: (value) {
                canvasState.updateComponentProperties(pageId, component.id, {'fit': value});
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: component.properties['borderRadius']?.toString() ?? '0',
              decoration: InputDecoration(labelText: 'Border Radius'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                canvasState.updateComponentProperties(pageId, component.id, {'borderRadius': double.tryParse(value)});
              },
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text('Has Shadow'),
              value: component.properties['hasShadow'] ?? false,
              onChanged: (value) {
                canvasState.updateComponentProperties(pageId, component.id, {'hasShadow': value});
              },
            ),
          ],
        ),
      );
    },
  );
}
  Future<Color?> showColorPicker(BuildContext context, int initialColor) async {
    Color pickedColor = Color(initialColor);
    return await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (Color color) {
                pickedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(pickedColor);
              },
            ),
          ],
        );
      },
    );
  }



 Widget _buildButtonEditForm(BuildContext context, String pageId, CanvasComponent component) {
    final canvasState = Provider.of<CanvasState>(context, listen: false);
    final pageState = Provider.of<PageState>(context, listen: false);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: component.properties['text'] ?? 'Button',
                decoration: InputDecoration(labelText: 'Button Text'),
                onChanged: (value) {
                  canvasState.updateComponentProperties(pageId, component.id, {'text': value});
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: component.properties['action'] ?? 'none',
                decoration: InputDecoration(labelText: 'Action'),
                items: ['none', 'navigate'].map((action) {
                  return DropdownMenuItem<String>(
                    value: action,
                    child: Text(action),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    canvasState.updateComponentProperties(pageId, component.id, {'action': value});
                    if (value != 'navigate') {
                      canvasState.updateComponentProperties(pageId, component.id, {'navigateTo': null});
                    }
                  });
                },
              ),
              SizedBox(height: 10),
              if (component.properties['action'] == 'navigate')
                DropdownButtonFormField<String>(
                  value: component.properties['navigateTo'] ?? pageState.pages.first.id,
                  decoration: InputDecoration(labelText: 'Navigate To'),
                  items: pageState.pages.map((page) {
                    return DropdownMenuItem<String>(
                      value: page.id,
                      child: Text(page.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      canvasState.updateComponentProperties(pageId, component.id, {'navigateTo': value});
                    }
                  },
                ),
              SizedBox(height: 10),
              DropdownButtonFormField<String?>(
                value: component.properties['iconName'],
                decoration: InputDecoration(labelText: 'Icon'),
                items: [
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text('No Icon'),
                  ),
                  ...['add', 'delete', 'edit', 'favorite', 'search', 'settings',
                    'share', 'home', 'person', 'shopping_cart'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(_getIconData(value)),
                          SizedBox(width: 10),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  canvasState.updateComponentProperties(pageId, component.id, {'iconName': value});
                },
              ),
              SizedBox(height: 10),
              if (component.properties['iconName'] != null)
                SwitchListTile(
                  title: Text('Icon Position'),
                  subtitle: Text(component.properties['isIconLeading'] ?? true ? 'Leading' : 'Trailing'),
                  value: component.properties['isIconLeading'] ?? true,
                  onChanged: (value) {
                    canvasState.updateComponentProperties(pageId, component.id, {'isIconLeading': value});
                  },
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final Color? color = await showColorPicker(context, component.properties['backgroundColor'] ?? 0xFF2196F3);
                  if (color != null) {
                    canvasState.updateComponentProperties(pageId, component.id, {'backgroundColor': color.value});
                  }
                },
                child: Text('Background Color'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final Color? color = await showColorPicker(context, component.properties['textColor'] ?? 0xFFFFFFFF);
                  if (color != null) {
                    canvasState.updateComponentProperties(pageId, component.id, {'textColor': color.value});
                  }
                },
                child: Text('Text Color'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: (component.properties['borderRadius'] ?? 4.0).toString(),
                decoration: InputDecoration(labelText: 'Border Radius'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  canvasState.updateComponentProperties(pageId, component.id, {'borderRadius': double.tryParse(value) ?? 4.0});
                },
              ),
            ],
          ),
        );
      },
    );
  }


}