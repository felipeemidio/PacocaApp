import 'package:flutter/material.dart';
import 'package:pacocaApp/consts/mock_data.dart';
import 'package:pacocaApp/models/product.dart';

class ItemsListPage extends StatefulWidget {
  @override
  _ItemsListPageState createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  final productFieldController = TextEditingController();

  @override
  void dispose() {
    productFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      int biggestId = 0;
      mockProductsList.forEach((element) {
        if(element.id > biggestId) {
          biggestId = element.id;
        }
      });
      final newProduct = Product(biggestId, productFieldController.text);
      mockProductsList.add(newProduct);
      productFieldController.clear();
    });
  }


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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              controller: productFieldController,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: 'Novo produto',
                suffixIcon: IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.add),
                  onPressed: _submit,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mockProductsList.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(mockProductsList[index].name),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
