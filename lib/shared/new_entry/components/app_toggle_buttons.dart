import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../design_sys/colors.dart';
import '../entry_change_notifier.dart';

class AppToggleButtons extends StatefulWidget {
  const AppToggleButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<AppToggleButtons> createState() => _AppToggleButtonsState();
}

class _AppToggleButtonsState extends State<AppToggleButtons> {
  final List<bool> _select = <bool>[true, false, false];
  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => ToggleButtons(
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _select.length; i++) {
              _select[i] = i == index;
            }
            if (index == 0) {
              notifier.changeLabel(normal: true);
            } else {
              notifier.changeLabel(normal: false);
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).backgroundColor == AppColors.black
            ? AppColors.white
            : notifier.color,
        selectedColor: Theme.of(context).backgroundColor,
        fillColor: notifier.color,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: _select,
        children: const [
          Text('Normal'),
          Text('Fixa'),
          Text('Parcelada'),
        ],
      ),
    );
  }
}
