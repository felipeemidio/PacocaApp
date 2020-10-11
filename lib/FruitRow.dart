import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import './Fruit.dart';

class FruitRow extends StatefulWidget {
  FruitRow({Key key, this.item, this.index, this.onCheck}) : super(key: key);
  final Fruit item;
  final int index;
  final Function onCheck;

  @override
  _FruitRow createState() => _FruitRow();
}

class _FruitRow extends State<FruitRow> {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: widget.item.selected,
                onChanged: (newState) {
                  setState(() {
                    widget.item.selected = !widget.item.selected;
                    widget.onCheck();
                  });
                })
          ],
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.name,
                style: textStyle,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(f.format(widget.item.price), style: textStyle)],
          ),
        ),
      ],
    );
  }
}
