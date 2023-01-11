import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class PartsFormField extends StatelessWidget {
  const PartsFormField(
    this.partsController, {
    super.key,
    required this.totalValueNotifier,
  });

  final TextEditingController partsController;
  final ValueNotifier<double> totalValueNotifier;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: Sizes.smallSpace),
          child: Row(
            children: [
              const Expanded(flex: 2, child: SizedBox.shrink()),
              Expanded(
                child: TextFormField(
                  controller: partsController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: state.color),
                    labelStyle: TextStyle(color: state.color.withOpacity(0.6)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: state.color),
                    ),
                  ),
                  onChanged: (_) {
                    final value = totalValueNotifier.value;
                    totalValueNotifier.value = 0;
                    totalValueNotifier.value = value;
                  },
                  cursorColor: Theme.of(context).dividerColor,
                  onSaved: (value) {
                    if (value?.isEmpty ?? true) {
                      partsController.text = '2';
                    }
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: totalValueNotifier,
                builder: (_, value, ___) {
                  final partValue =
                      value / (int.tryParse(partsController.text) ?? 2);
                  return Text(
                      'x de R\$ ${partValue.toStringAsFixed(2).replaceAll('.', ',')}');
                },
              ),
              const Expanded(flex: 2, child: SizedBox.shrink()),
            ],
          ),
        );
      },
    );
  }
}
