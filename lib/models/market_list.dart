import 'package:intl/intl.dart';

import 'market_item.dart';

class MarketList {
  int id;
  String title;
  DateTime createdAt;
  List<MarketItem> items;

  MarketList(int id, String title) {
    this.id = id;
    this.title = title;
    this.createdAt = DateTime.now();
    this.items = [];
  }

  @override
  String toString() {
    return 'MarketList {\n'
        '  id: $id,\n'
        '  name: $title,\n'
        '  createdAt: ${DateFormat('dd/MM/yyyy – kk:mm').format(createdAt)},\n'
        '  numOfItems: ${items.length},\n'
        '}\n';
  }
}