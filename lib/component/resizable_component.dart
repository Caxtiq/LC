import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class ResizableComponent extends StatefulWidget {
  final CanvasComponent component;
  final Widget child;
  final Function(Size) onResize;
  final Function(Offset) onMove;

  ResizableComponent({
    Key? key,
    required this.component,
    required this.child,
    required this.onResize,
    required this.onMove,
  }) : super(key: key);

  @override
  _ResizableComponentState createState() => _ResizableComponentState();
}

class _ResizableComponentState extends State<ResizableComponent> {
  late Size size;
  late Offset position;

  @override
  void initState() {
    super.initState();
    size = widget.component.size;
    position = widget.component.position;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
          widget.onMove(position);
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              widget.child,
              ...buildResizeHandles(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildResizeHandles() {
    return [
      buildResizeHandle(Alignment.topLeft, Offset(-1, -1)),
      buildResizeHandle(Alignment.topRight, Offset(1, -1)),
      buildResizeHandle(Alignment.bottomLeft, Offset(-1, 1)),
      buildResizeHandle(Alignment.bottomRight, Offset(1, 1)),
    ];
  }

  Widget buildResizeHandle(Alignment alignment, Offset resizeDirection) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            size = Size(
              size.width + details.delta.dx * resizeDirection.dx,
              size.height + details.delta.dy * resizeDirection.dy,
            );
            if (resizeDirection.dx < 0 || resizeDirection.dy < 0) {
              position = Offset(
                position.dx + (resizeDirection.dx < 0 ? details.delta.dx : 0),
                position.dy + (resizeDirection.dy < 0 ? details.delta.dy : 0),
              );
            }
          });
          widget.onResize(size);
          if (resizeDirection.dx < 0 || resizeDirection.dy < 0) {
            widget.onMove(position);
          }
        },
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.open_in_full, size: 12, color: Colors.white),
        ),
      ),
    );
  }
}