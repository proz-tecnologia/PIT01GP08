import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class PaymentFormField extends StatefulWidget {
  const PaymentFormField({
    Key? key,
    required this.color,
    required this.controller,
  }) : super(key: key);

  final Color color;
  final ValueNotifier<int> controller;

  @override
  State<PaymentFormField> createState() => _PaymentFormFieldState();
}

class _PaymentFormFieldState extends State<PaymentFormField> {
  final List<bool> _select = <bool>[true, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _select.length; i++) {
            _select[i] = i == index;
          }
          widget.controller.value = index;
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.white
          : widget.color,
      selectedColor: Theme.of(context).colorScheme.background,
      fillColor: widget.color,
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
  }
}
