import 'package:flutter/material.dart';

class DraggableComponentTile extends StatelessWidget {
  final String type;

  DraggableComponentTile({required this.type});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: type,
      child: ListTile(title: Text(type)),
      feedback: Material(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.blue[100],
          child: Text(type),
        ),
      ),
      childWhenDragging: ListTile(title: Text(type), enabled: false),
    );
  }
}