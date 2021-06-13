import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pacocaApp/consts/mock_data.dart';
import 'package:pacocaApp/pages/create_market_list_page.dart';
import 'package:pacocaApp/pages/items_list_page.dart';
import 'package:pacocaApp/pages/market_list_detail_page.dart';

class SavedListsPage extends StatefulWidget {
  @override
  _SavedListsPageState createState() => _SavedListsPageState();
}

class _SavedListsPageState extends State<SavedListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listas Salvas',
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ItemsListPage()),
              );
            },
            icon: Icon(Icons.list),
          ),
        ],
      ),
      floatingActionButton: mockProductsList.isEmpty ? null : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CreateMarketListPage(
              onCreate: (newMarketList) {
                setState(() {
                  mockMarketLists.add(newMarketList);
                });
              },
            )),
          );
        },
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: mockMarketLists.isEmpty ? Center(
          child: Text('Nenhuma lista salva'),
        ) : ListView.builder(
          itemCount: mockMarketLists.length,
          itemBuilder: (_, index) {
            final currentMarketList = mockMarketLists[index];
            return ListTile(
              title: Text(currentMarketList.title),
              subtitle: Text(DateFormat('dd/MM/yyyy – kk:mm').format(currentMarketList.createdAt)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MarketListDetailPage(marketList: currentMarketList)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
