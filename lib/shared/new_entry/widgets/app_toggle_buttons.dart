import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class AppToggleButtons extends StatefulWidget {
  const AppToggleButtons({
    Key? key,
    required List<bool> select,
    required Color color,
  })  : _select = select,
        _color = color,
        super(key: key);

  final List<bool> _select;
  final Color _color;

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
