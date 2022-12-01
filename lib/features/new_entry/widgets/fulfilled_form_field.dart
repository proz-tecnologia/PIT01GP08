import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class FulfilledFormField extends StatelessWidget {
  const FulfilledFormField({
    Key? key,
    required this.boolController,
    required this.color,
    required this.label,
  }) : super(key: key);

  final ValueNotifier<bool> boolController;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boolController,
      builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Previsto'),
            Switch(
                activeTrackColor: color,
                activeColor: AppColors.white,
                value: value,
                onChanged: (value) => boolController.value = value),
            Text(label),
          ],
        );
      },
    );
  }
}

