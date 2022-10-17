import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class AppToggleButtons extends StatefulWidget {
  const AppToggleButtons({
    Key? key,
    required List<bool> select,
    required Color color,
    required ValueNotifier<String> labelNotifier,
  })  : _select = select,
        _color = color,
        _fulfilledLabel = labelNotifier,
        super(key: key);

  final List<bool> _select;
  final Color _color;
  final ValueNotifier<String> _fulfilledLabel;

  @override
  State<AppToggleButtons> createState() => _AppToggleButtonsState();
}

class _AppToggleButtonsState extends State<AppToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < widget._select.length; i++) {
            widget._select[i] = i == index;
          }
          if (index == 0) {
            widget._fulfilledLabel.value =
                widget._color == AppColors.expense ? 'Pago' : 'Recebido';
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
          : widget._color,
      selectedColor: Theme.of(context).backgroundColor,
      fillColor: widget._color,
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: widget._select,
      children: const [
        Text('Normal'),
        Text('Fixa'),
        Text('Parcelada'),
      ],
    );
  }
}
