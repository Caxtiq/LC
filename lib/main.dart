import 'package:flutter/material.dart';
import 'package:flutterswing/states/canvas_state.dart';
import 'package:flutterswing/pages/lcd_home_page.dart';
import 'package:flutterswing/states/page_state.dart';
import 'package:flutterswing/states/to_do_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CanvasState()),
        ChangeNotifierProvider(create: (context) => PageState()),
        ChangeNotifierProvider(create: (context) => TodoState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LCDP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LCDPHomePage(),
    );
  }
}

