import 'package:flutter/material.dart';

import '../../design_sys/sizes.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.smart_toy_rounded,
            size: Sizes.extraLargeIconSize,
          ),
          const SizedBox(height: Sizes.smallSpace),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
