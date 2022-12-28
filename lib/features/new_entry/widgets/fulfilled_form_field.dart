import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/colors.dart';
import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class FulfilledFormField extends StatelessWidget {
  const FulfilledFormField(
    this.boolController, {
    super.key,
  });

  final ValueNotifier<bool> boolController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: boolController,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Previsto'),
                Switch(
                    activeTrackColor: state.color,
                    activeColor: AppColors.white,
                    value: value,
                    onChanged: (value) => boolController.value = value),
                Text(state.initialFulfilledLabel),
              ],
            );
          },
        );
      },
    );
  }
}
