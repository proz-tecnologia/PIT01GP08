import 'package:flutter/material.dart';

import '../../../design_sys/sizes.dart';
import '../constants/color_options.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker(this.notifier, {super.key});

  final ValueNotifier<Color> notifier;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Escolha uma cor',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Sizes.largeIconSize,
            mainAxisSpacing: Sizes.mediumSpace,
            crossAxisSpacing: Sizes.mediumSpace,
          ),
          itemCount: colorOptions.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () {
              notifier.value = colorOptions[index];
              Navigator.of(context).pop();
            },
            child: CircleAvatar(backgroundColor: colorOptions[index]),
          ),
        ),
      ),
    );
  }
}
