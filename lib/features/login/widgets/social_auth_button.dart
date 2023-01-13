import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';
import '../../../design_sys/sizes.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton(
      {super.key,
      required this.onPressed,
      required this.asset,
      required this.text});

  final VoidCallback onPressed;
  final String asset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.lightGrey),
            foregroundColor: const MaterialStatePropertyAll(AppColors.black),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.all(Sizes.smallSpace)),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: Sizes.mediumIconSize,
            image: AssetImage(asset),
          ),
          const SizedBox(width: Sizes.mediumSpace),
          Text(text),
        ],
      ),
    );
  }
}
