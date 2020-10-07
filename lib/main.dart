import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import './Fruit.dart';
import './FruitTable.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paçoca',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Paçoca App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Fruit> items = [
    Fruit(0, "Maçã", 5.66),
    Fruit(1, "Banana", 4),
    Fruit(2, "Abacaxi", 3),
    Fruit(3, "Laranja", 1.50),
    Fruit(4, "Kiwi", 6),
    // Fruit(5, "Ameixa", 3),
    // Fruit(6, "Melão", 4.2),
    // Fruit(7, "Melancia", 4.1),
    // Fruit(8, "Uva", 2),
    // Fruit(9, "Mamão", 2.3),
  ];
  List<Fruit> checkedItems = [];
  int counter = 10;
  final GlobalKey<FruitTableState> tableKey = GlobalKey<FruitTableState>();

  void _incrementCounter(formState) {
    setState(() {
      counter += 1;
      tableKey.currentState.insertFruit(items.length);
      items.add(Fruit(counter, formState['name'], formState['price']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 24.0),
        ),
      ),
      body: FruitTable(key: tableKey, fruits: items),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () {
          fruitFormDialog(context, _incrementCounter);
        },
      ),
    );
  }
}

Future<dynamic> fruitFormDialog(context, onSave) {
  final _formKey = GlobalKey<FormState>();
  var mController = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  String _itemName;
  double _value;

  return showDialog(
    context: context,
    builder: (_) => SimpleDialog(
      title: Text('Novo item'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Item...'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Digite o nome do item';
                    }
                    return null;
                  },
                  onSaved: (input) => _itemName = input,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  controller: mController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Preço...'),
                  onSaved: (input) {
                    if (mController.numberValue == 0) {
                      print("valor igual a 0");
                    } else {
                      print("valor diferente de 0");
                    }
                    _value = mController.numberValue;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: RaisedButton(
                  color: Colors.indigo,
                  child: Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      onSave({'name': _itemName, 'price': _value});
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
