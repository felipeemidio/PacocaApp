import 'package:flutter/material.dart';
import 'package:pacocaApp/consts/mock_data.dart';

class ItemsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mockProductsList.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(mockProductsList[index].name),
        ),
      ),
    );
  }
}
