import 'package:flutter/material.dart';
import 'package:pacocaApp/pages/saved_lists_page.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paçoca',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SavedListsPage(),
    );
  }
}
