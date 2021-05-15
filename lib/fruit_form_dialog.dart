import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FruitFormDialog extends StatefulWidget {
  final void Function(String, double) onSubmit;

  FruitFormDialog({this.onSubmit});

  @override
  _FruitFormDialogState createState() => _FruitFormDialogState();
}

class _FruitFormDialogState extends State<FruitFormDialog> {
  final _formKey = GlobalKey<FormState>();

  var priceField = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final nameField = TextEditingController();

  @override
  void dispose() {
    priceField.dispose();
    nameField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
                  controller: nameField,
                  decoration: InputDecoration(hintText: 'Item...'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Digite o nome do item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  controller: priceField,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Preço...'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: ElevatedButton(
                  child: Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget.onSubmit(
                        nameField.text,
                        priceField.numberValue,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
