import 'package:flutter/material.dart';

import '../../../../design_sys/sizes.dart';
import '../../../../shared/widgets/animated_logo.dart';
import '../widgets/custom_circular_progress.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final Image logo = Image.asset('assets/logo_colors.png');

    return Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: Sizes.extraLargeIconSize,
              child: AnimatedLogo(logo: logo),
            ),
            const CustomCircularProgress(),
          ],
        ),
    );
  }
}
