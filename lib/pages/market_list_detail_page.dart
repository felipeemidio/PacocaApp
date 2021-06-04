import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pacocaApp/models/market_item.dart';
import 'package:pacocaApp/models/market_list.dart';
import 'package:pacocaApp/shared/widgets/item_checkbox_tile.dart';


class MarketListDetailPage extends StatefulWidget {
  final MarketList marketList;

  MarketListDetailPage({Key key, this.marketList}) : super(key: key);

  @override
  _MarketListDetailPageState createState() => _MarketListDetailPageState();
}

class _MarketListDetailPageState extends State<MarketListDetailPage> {
  bool showDone = false;
  NumberFormat formatter = NumberFormat.currency(symbol: 'R\$', locale: 'pt_BR');

  @override
  void initState() {
    super.initState();
    if(widget.marketList.items.isNotEmpty) {
      widget.marketList.items.sort(_sortItemsList);
    }
  }

  /// Function to sort a list of MarketItems
  int _sortItemsList(MarketItem itemA, MarketItem itemB) {
    if(itemA.selected == itemB.selected) {
      if(itemA.id == itemB.id) {
        return 0;
      }
      return itemA.id > itemB.id ? 1 : -1;
    }

    return itemA.selected && !itemB.selected ? 1 : -1;
  }

  /// Function to filter undone items
  List<MarketItem> _filterList(List<MarketItem> items) {
    if(showDone) {
      return items;
    }

    List<MarketItem> newList = [];
    for(MarketItem f in items) {
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

    final filteredItems = _filterList(widget.marketList.items);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.marketList.title,
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
        centerTitle: true,
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
          final currentItem = widget.marketList.items[index];
          return ItemCheckboxTile(
            title: currentItem.name,
            selected: currentItem.selected,
            onTap: (checked) {
              setState(() {
                currentItem.selected = checked;
                widget.marketList.items.sort(_sortItemsList);
              });
            },
            action: Text(formatter.format(currentItem.price)),
          );
        },
      ),
    );
  }
}