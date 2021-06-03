import 'package:flutter/material.dart';

class ItemsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (_, index) => ListTile(
          title: Text('Item ${index + 1}'),
        ),
      ),
    );
  }
}
