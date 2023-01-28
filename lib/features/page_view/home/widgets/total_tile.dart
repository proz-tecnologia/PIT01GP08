import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/sizes.dart';
import '../../../../shared/utils/currency_format.dart';
import '../home_controller.dart';

class TotalTile extends StatelessWidget {
  const TotalTile({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  final IconData? icon;
  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) {
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
            value != null
                ? ValueListenableBuilder(
                    valueListenable: context.read<HomeController>().isVisible,
                    builder: (_, isVisible, __) {
                      return Text(
                        isVisible ? value!.toBrReal : 'R\$ -------',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      );
                    })
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: SizedBox(
                      width: Sizes.extraLargeIconSize,
                      child: LinearProgressIndicator(
                        minHeight: Sizes.smallSpace,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.2),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
