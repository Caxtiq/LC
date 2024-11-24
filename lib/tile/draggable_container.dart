import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';
import 'package:flutterswing/widgets/custom_button.dart';
import 'package:flutterswing/widgets/custom_image.dart';
import 'package:flutterswing/widgets/custom_text_field.dart';



class DraggableContainer extends StatefulWidget {
  const DraggableContainer({Key? key}) : super(key: key);

  @override
  _DraggableContainerState createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer> {
  List<CanvasComponent> _components = [];  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Stack(
        children: [
          DragTarget<Map<String, dynamic>>(
            onAccept: (data) {
              _addComponentToContainer(data['type']);
            },
            builder: (context, candidateData, rejectedData) {
              return const Center(
                child: Text(
                  "Drag here",
                  style: TextStyle(color: Colors.black54),
                ),
              );
            },
          ),
          ..._components.map((component) {
            return Positioned(
              top: component.position.dy,
              left: component.position.dx,
              child: _createWidget(component),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _addComponentToContainer(String type) {
    setState(() {
      _components.add(CanvasComponent(
        id: UniqueKey().toString(),
        type: type,
        position: Offset(0, 0),
        size: Size(300, 300),  
      ));
    });
  }

  Widget _createWidget(CanvasComponent component) {
    return GestureDetector(
      onTap: () {
      },
      child: _buildWidgetByType(component),
    );
  }

  Widget _buildWidgetByType(CanvasComponent component) {
    switch (component.type) {
      case 'TextField':
        return CustomTextField(component: component);
      case 'Button':
        return CustomButton(component: component);
      case 'Image':
        return CustomImage(component: component);
      default:
        return Container();
    }
  }
}
