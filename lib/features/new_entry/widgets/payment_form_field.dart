import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../design_sys/colors.dart';
import '../../page_view/shared/models/transaction.dart';
import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class PaymentFormField extends StatefulWidget {
  const PaymentFormField(
    this.controller, {
    super.key,
  });

  final ValueNotifier<int> controller;

  @override
  State<PaymentFormField> createState() => _PaymentFormFieldState();
}

class _PaymentFormFieldState extends State<PaymentFormField> {
  final List<bool> _select = List.from(Payment.values.map((e) => false));

  @override
  void initState() {
    super.initState();
    _select.first = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
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
              : state.color,
          selectedColor: Theme.of(context).colorScheme.background,
          fillColor: state.color,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: _select,
          children: Payment.values
              .map((e) => Text(toBeginningOfSentenceCase(e.name)!))
              .toList(),
        );
      },
    );
  }
}
