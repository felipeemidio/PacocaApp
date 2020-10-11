import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './Fruit.dart';
import './FruitRow.dart';

class FruitTable extends StatefulWidget {
  FruitTable({Key key, this.fruits}) : super(key: key);
  final List<Fruit> fruits;

  @override
  FruitTableState createState() => FruitTableState();
}

class FruitTableState extends State<FruitTable> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  // List<Fruit> checkedFruits = new List<Fruit>();

  void _removeFruitElement(index) {
    print("_removeCounter in pos " + index.toString());
    setState(() {
      widget.fruits.removeAt(index);
    });
  }

  void sortList() {
    setState(() {
      widget.fruits.sort((itemA, itemB) {
        if (itemA.selected == itemB.selected) {
          if (itemA.id > itemB.id) {
            return 1;
          }
          if (itemA.id < itemB.id) {
            return -1;
          }
          return 0;
        }
        return itemA.selected && !itemB.selected ? 1 : 0;
      });
    });
  }

  void insertFruit(index) {
    setState(() {
      listKey.currentState.insertItem(index);
    });

    print("insert fruit in position " + index.toString());
  }

  void removeFruit(index) {
    Fruit removedFruit = widget.fruits.removeAt(index);
    print("_removeFruit in pos " + index.toString());
    listKey.currentState.removeItem(
      index,
      (_, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: createRow(removedFruit),
      ),
    );
  }

  Widget createRow(Fruit fruit) {
    print("create row " + fruit.name);
    int index = widget.fruits.indexOf(fruit);
    if (index >= widget.fruits.length) {
      return null;
    }
    return Dismissible(
      key: Key(fruit.id.toString()),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (item) {
        _removeFruitElement(index);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: FruitRow(
          item: fruit,
          index: index,
          onCheck: () {
            removeFruit(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext build) {
    sortList();
    return AnimatedList(
      key: listKey,
      shrinkWrap: true,
      initialItemCount: widget.fruits.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(animation),
          child: index < widget.fruits.length
              ? createRow(widget.fruits[index])
              : null,
        );
      },
    );
  }
}
