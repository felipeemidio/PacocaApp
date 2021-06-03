import 'package:flutter/material.dart';
import 'package:pacocaApp/market_list_page.dart';
import 'package:pacocaApp/pages/itemsList/items_list_page.dart';

class SavedListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas Salvas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ItemsListPage()),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MarketListPage(title: 'PaçocaApp')),
              );
            },
            icon: Icon(Icons.bug_report),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text('Nenhuma lista salva'),
        ),
      ),
    );
  }
}
