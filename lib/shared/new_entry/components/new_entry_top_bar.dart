import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entry_change_notifier.dart';

class NewEntryTopBar extends StatefulWidget {
  NewEntryTopBar({Key? key}) : super(key: key);

  final List<bool> _select = <bool>[true, false];

  @override
  State<NewEntryTopBar> createState() => _NewEntryTopBarState();
}

class _NewEntryTopBarState extends State<NewEntryTopBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => ToggleButtons(
        constraints: const BoxConstraints(minWidth: 146),
        selectedColor: notifier.color,
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
            notifier.changeType(index == 0 ? Type.expense : Type.income);
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
      ),
    );
  }
}
