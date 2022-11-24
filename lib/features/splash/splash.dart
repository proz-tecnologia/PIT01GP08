import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/animated_logo.dart';
import 'widgets/app_progress.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Image _logo = Image.asset('assets/logo_white_flat.png');
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then(
      (_) => Navigator.of(context).pushReplacementNamed('/home-page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: AnimatedLogo(logo: _logo),
            ),
            const AppProgress(),
          ],
        ),
      ),
    );
  }
}
