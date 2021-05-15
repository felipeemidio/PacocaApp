import 'package:flutter/material.dart';

class ItemCheckboxTile extends StatelessWidget {
  final bool selected;
  final String title;
  final Widget action;
  final void Function(bool) onTap;

  const ItemCheckboxTile({
    Key key,
    @required this.selected,
    @required this.title,
    this.onTap,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Checkbox(
        value: selected,
        onChanged: (newState) {
          if(onTap != null) {
            onTap(newState);
          }
        }),
        Expanded(
          child: Text(title,),
        ),
        action != null ? action : Container(),
      ],
    );
  }
}
