import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterswing/component/canvas_component.dart';

class CustomImage extends StatelessWidget {
  final CanvasComponent component;

  const CustomImage({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = component.properties['imageUrl'] ?? 'ehe';
    final BoxFit fit = _getBoxFit(component.properties['fit']);
    final BorderRadius borderRadius = BorderRadius.circular(component.properties['borderRadius']?.toDouble() ?? 8.0);

    return Container(
      width: component.size.width,
      height: component.size.height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          if (component.properties['hasShadow'] == true)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: imageUrl.startsWith('file://')
          ? Image.file(
              File(imageUrl.replaceFirst('file://', '')),
              fit: fit,
              width: component.size.width,
              height: component.size.height,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            )
          : Image.network(
              imageUrl,
              fit: fit,
              width: component.size.width,
              height: component.size.height,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildLoadingWidget(loadingProgress);
              },
            ),
      ),
    );
  }

  BoxFit _getBoxFit(String? fit) {
    switch (fit) {
      case 'cover':
        return BoxFit.cover;
      case 'contain':
        return BoxFit.contain;
      case 'fill':
        return BoxFit.fill;
      case 'fitWidth':
        return BoxFit.fitWidth;
      case 'fitHeight':
        return BoxFit.fitHeight;
      case 'none':
        return BoxFit.none;
      case 'scaleDown':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.error, color: Colors.red, size: 48),
    );
  }

  Widget _buildLoadingWidget(ImageChunkEvent loadingProgress) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }
}