import 'package:flutter/material.dart';

import '../../../design_sys/sizes.dart';
import '../constants/icon_options.dart';

class IconPicker extends StatelessWidget {
  const IconPicker(this.notifier, {super.key});

  final ValueNotifier<IconData> notifier;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Escolha um ícone',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Sizes.extraLargeIconSize,
          ),
          itemCount: iconOptions.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () {
              notifier.value = iconOptions[index];
              Navigator.of(context).pop();
            },
            child: Icon(
              iconOptions[index],
              size: Sizes.largeIconSize,
            ),
          ),
        ),
      ),
    );
  }
}
