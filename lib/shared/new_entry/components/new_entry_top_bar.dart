import 'package:flutter/material.dart';

import '../entry_types.dart';

class NewEntryTopBar extends StatefulWidget {
  NewEntryTopBar(
    this._type,
    this._fulfilledLabel, {
    Key? key,
  }) : super(key: key);

  final List<bool> _select = <bool>[true, false];
  final ValueNotifier<EntryType> _type;
  final ValueNotifier<String> _fulfilledLabel;

  @override
  State<NewEntryTopBar> createState() => _NewEntryTopBarState();
}

class _NewEntryTopBarState extends State<NewEntryTopBar> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: const BoxConstraints(minWidth: 146),
      selectedColor: widget._type.value.color,
      fillColor: Theme.of(context).backgroundColor,
      renderBorder: false,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < widget._select.length; i++) {
            widget._select[i] = i == index;
          }
          widget._type.value =
              index == 0 ? EntryTypes.expense : EntryTypes.income;
          widget._fulfilledLabel.value = widget._type.value.fulfilledLabel;
        });
      },
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      isSelected: widget._select,
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Despesa'),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Receita'),
        ),
      ],
    );
  }
}
