import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './Fruit.dart';
import './CustomItem.dart';

class FruitTable extends StatefulWidget {
  FruitTable({Key key, this.fruits}) : super(key: key);
  final List<Fruit> fruits;

  @override
  FruitTableState createState() => FruitTableState();
}

class FruitTableState extends State<FruitTable> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void _removeCounter(index) {
    print("_removeCounter in pos " + index);
    setState(() {
      widget.fruits.removeAt(index);
    });
  }

  void insertFruit(index) {
    setState(() {
      listKey.currentState.insertItem(index);
    });

    print("insert fruit in position " + index.toString());
  }

  void _removeFruit(index) {
    print("_removeFruit in pos " + index);
    listKey.currentState.removeItem(
      index,
      (_, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child: createRow(index),
      ),
    );
  }

  Widget createRow(int index) {
    return Dismissible(
      key: Key(widget.fruits[index].id.toString()),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (item) {
        setState(() {
          print('removed ' + index.toString());
          _removeCounter(index);
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: CustomItem(
            item: widget.fruits[index],
            index: index,
            onCheck: () {
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
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext build) {
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

    List<Widget> items = [];
    for (var i = 0; i < widget.fruits.length; i++) {
      items.add(createRow(i));
    }
    // return ListView(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.vertical,
    //   children: items,
    // );
    return AnimatedList(
      key: listKey,
      shrinkWrap: true,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset(0, 0),
          ).animate(animation),
          child: createRow(index),
        );
      },
    );
  }
}
