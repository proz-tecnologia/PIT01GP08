import 'package:financial_app/shared/new_entry/entry_types.dart';
import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class AppToggleButtons extends StatefulWidget {
  const AppToggleButtons({
    Key? key,
    required ValueNotifier<EntryType> typeNotifier,
    required ValueNotifier<String> labelNotifier,
  })  : _typeNotifier = typeNotifier,
        _fulfilledLabel = labelNotifier,
        super(key: key);

  final ValueNotifier<EntryType> _typeNotifier;
  final ValueNotifier<String> _fulfilledLabel;

  @override
  State<AppToggleButtons> createState() => _AppToggleButtonsState();
}

class _AppToggleButtonsState extends State<AppToggleButtons> {
  final List<bool> _select = <bool>[true, false, false];
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._typeNotifier,
      builder: (context, child) {
        final color = widget._typeNotifier.value.color;
        return ToggleButtons(
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _select.length; i++) {
                _select[i] = i == index;
              }
              if (index == 0) {
                widget._fulfilledLabel.value =
                    color == AppColors.expense ? 'Pago' : 'Recebido';
              } else {
                if (!widget._fulfilledLabel.value.contains('(mês atual)')) {
                  widget._fulfilledLabel.value += ' (mês atual)';
                }
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).backgroundColor == AppColors.black
              ? AppColors.white
              : color,
          selectedColor: Theme.of(context).backgroundColor,
          fillColor: color,
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
        );
      },
    );
  }
}
