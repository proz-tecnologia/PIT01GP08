import 'package:flutter/material.dart';

import '../../design_sys/sizes.dart';

class TotalTile extends StatelessWidget {
  const TotalTile({
    Key? key,
    this.icon,
    required this.label,
    required this.value,
    required this.visible,
  }) : super(key: key);

  final IconData? icon;
  final String label;
  final String value;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final hidden = Container(
      color: Theme.of(context).colorScheme.onPrimary,
      width: 72.0,
      height: 11.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
    );
    final leading = icon == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(right: Sizes.mediumSpace),
            child: Icon(
              icon,
              size: Sizes.mediumIconSize,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          );
    return Row(
      children: [
        leading,
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
            visible
                ? Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : hidden,
          ],
        ),
      ],
    );
  }
}
