import 'package:flutter/material.dart';

import '../../../../design_sys/sizes.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.mediumSpace),
        child: Column(
          children: [
            Icon(
              icon,
              size: Sizes.largeIconSize,
              color: color,
            ),
            Text(label),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
