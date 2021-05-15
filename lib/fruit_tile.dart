import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import './fruit.dart';

class FruitTile extends StatefulWidget {
  FruitTile({Key key, this.item, this.onCheck}) : super(key: key);
  final Fruit item;
  final Function onCheck;

  @override
  _FruitTile createState() => _FruitTile();
}

class _FruitTile extends State<FruitTile> {
  @override
  Widget build(BuildContext build) {
    NumberFormat f = NumberFormat.currency(symbol: 'R\$', locale: 'pt_BR');
    TextStyle textStyle = TextStyle(
        color: widget.item.selected ? Colors.black26 : Colors.black87,
        fontSize: 16,
        decoration: widget.item.selected
            ? TextDecoration.lineThrough
            : TextDecoration.none);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Checkbox(
          value: widget.item.selected,
          onChanged: (newState) {
            setState(() {
              widget.item.selected = !widget.item.selected;
              widget.onCheck();
            });
        }),
        Expanded(
          flex: 2,
          child: Text(
            widget.item.name,
            style: textStyle,
          ),
        ),
        Text(f.format(widget.item.price), style: textStyle),
      ],
    );
  }
}
