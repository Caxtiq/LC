import 'package:flutter/material.dart';
import 'package:flutterswing/model/canvas.dart';
import 'package:flutterswing/model/side_bar.dart';
import 'package:flutterswing/states/page_state.dart';
import 'package:flutterswing/tile/draggable_component_tile.dart';
import 'package:provider/provider.dart';

class LCDPHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageState>(
      builder: (context, pageState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('LCDP Demo - ${pageState.pages.firstWhere((page) => page.id == pageState.currentPageId).name}'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _showAddPageDialog(context),
              ),
              PopupMenuButton<String>(
                onSelected: (pageId) => pageState.setCurrentPage(pageId),
                itemBuilder: (BuildContext context) {
                  return pageState.pages.map((page) {
                    return PopupMenuItem<String>(
                      value: page.id,
                      child: Text(page.name),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Row(
            children: [
              Sidebar(),
              Expanded(child: Canvas()),
            ],
          ),
        );
      },
    );
  }

  void _showAddPageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String pageName = '';
        return AlertDialog(
          title: Text('Add New Page'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Page Name'),
            onChanged: (value) => pageName = value,
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (pageName.isNotEmpty) {
                  Provider.of<PageState>(context, listen: false).addPage(pageName);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

