import 'package:flutter/material.dart';

import '../../../../design_sys/sizes.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: Sizes.extraLargeIconSize,
          ),
          const SizedBox(height: Sizes.smallSpace),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
