import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../design_sys/sizes.dart';
import 'splash_controller.dart';
import '../../shared/widgets/animated_logo.dart';
import 'widgets/app_progress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Image _logo = Image.asset('assets/logo_white.png');
  final controller = SplashController(authBio: LocalAuthentication());
  ValueNotifier<bool> isLoadAuthFailed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: Sizes.logoSize,
              child: AnimatedLogo(logo: _logo),
            ),
            BlocListener<SplashController, SplashState>(
              bloc: controller,
              listener: (context, state) async {
                final cnxt = Navigator.of(context);
                if (state == SplashState.unlogged) {
                  cnxt.pushReplacementNamed('/register-page');
                } else {
                  final isLocalAuthAvailable =
                      await controller.isBiometricAvailable();
                  isLoadAuthFailed.value = false;
                  if (isLocalAuthAvailable) {
                    final autenticate = await controller.authenticate();
                    if (!autenticate) {
                      // enviar para tela de login manual
                      cnxt.pushNamedAndRemoveUntil('/login', (route) => false);
                    } else {
                      cnxt.pushReplacementNamed('/home-page');
                    }
                  } else {
                    cnxt.pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                }
              },
              child: const AppProgress(),
            ),
          ],
        ),
      ),
    );
  }
}
