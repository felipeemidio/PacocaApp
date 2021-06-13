import 'package:flutter/material.dart';
import 'package:pacocaApp/consts/mock_data.dart';
import 'package:pacocaApp/models/market_item.dart';
import 'package:pacocaApp/models/market_list.dart';
import 'package:pacocaApp/shared/widgets/item_checkbox_tile.dart';

class CreateMarketListPage extends StatefulWidget {
  final void Function(MarketList) onCreate;

  CreateMarketListPage({@required this.onCreate});

  @override
  _CreateMarketListPageState createState() => _CreateMarketListPageState();
}

class _CreateMarketListPageState extends State<CreateMarketListPage> {
  List<int> checkedList = [];
  bool isSaving = false;
  final titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Lista',
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
                validator: (text) => text.isEmpty ? 'Campo obrigatório' :  null,
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                itemCount: mockProductsList.length,
                itemBuilder: (_, index) {
                  final currentItem = mockProductsList[index];
                  return ItemCheckboxTile(
                    title: currentItem.name,
                    selected: checkedList.contains(currentItem.id),
                    onTap: (checked) {
                      setState(() {
                        if (checked) {
                          checkedList.add(currentItem.id);
                        } else {
                          checkedList.remove(currentItem.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              height: 48,
              child: ElevatedButton(
                child: Text('SALVAR'),
                onPressed: isSaving ? null : () {
                  if(formKey.currentState.validate()) {
                    // Pega o maior id entre as listas de mercado.
                    int biggestId = -1;
                    mockMarketLists.forEach((element) {
                      if(element.id > biggestId) {
                        biggestId = element.id;
                      }
                    });

                    // Insere nova lista no mock.
                    List<MarketItem> items = [];
                    checkedList.forEach((element) {
                      items.add(
                        MarketItem(element, mockProductsList.firstWhere((p) => p.id == element).name),
                      );
                    });
                    final newMarketList = MarketList(biggestId + 1, titleController.text);
                    newMarketList.items = items;
                    widget.onCreate(newMarketList);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Lista salva com suceesso'),
                      )
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
