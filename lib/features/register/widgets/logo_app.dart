import 'package:flutter/material.dart';

import '../../../design_sys/sizes.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      width: Sizes.logoSize,
      height: Sizes.logoSize,
      image: AssetImage('assets/logo_colors.png'),
    );
  }
}
