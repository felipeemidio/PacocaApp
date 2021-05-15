import 'package:flutter/material.dart';
import 'package:pacocaApp/fruit_tile.dart';
import 'package:pacocaApp/fruit_form_dialog.dart';
import 'package:pacocaApp/item_checkbox_tile.dart';

import 'fruit.dart';

class MarketListPage extends StatefulWidget {
  final String title;

  MarketListPage({Key key, this.title}) : super(key: key);

  @override
  _MarketListPageState createState() => _MarketListPageState();
}

class _MarketListPageState extends State<MarketListPage> {
  bool showDone = false;
  int counter = 10;
  List<Fruit> items = [
    Fruit(0, "Maçã", 5.66),
    Fruit(1, "Banana", 4),
    Fruit(2, "Abacaxi", 3),
    Fruit(3, "Laranja", 1.50),
    Fruit(4, "Kiwi", 6),
  ];

  void _incrementCounter(String name, double price) {
    setState(() {
      counter += 1;
      items.add(Fruit(counter, name, price));
    });
  }

  List<Fruit> _filterList() {
    if(showDone) {
      return items;
    }

    List<Fruit> newList = [];
    for(Fruit f in items) {
      if(f.selected) {
        newList.add(f);
      }
    }
    return items.where((f) => !f.selected).toList();
  }

  void _toggleShowDone() {
    setState(() {
      showDone = !showDone;
    });
  }

  @override
  Widget build(BuildContext context) {

    final filteredItems = _filterList();
    print(filteredItems);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length + 1,
        itemBuilder: (_, index) {
          if(index == filteredItems.length) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 80,
                color: Colors.black45,
                alignment: Alignment.center,
                child: ItemCheckboxTile(
                  selected: showDone,
                  title: 'Mostrar itens marcados',
                  onTap: (_) => _toggleShowDone(),
                ),
              ),
            );
          }


          Fruit currentFruit = filteredItems[index];
          return FruitTile(
            item: currentFruit,
            onCheck: () {
              setState(() {
                final fruitIndex = items.indexOf(currentFruit);
                print('index $fruitIndex');
                items[fruitIndex].toggleSelection();
                currentFruit.toggleSelection();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          return showDialog(
            context: context,
            builder: (_) => FruitFormDialog(
              onSubmit: _incrementCounter,
            ),
          );
        },
      ),
    );
  }
}
