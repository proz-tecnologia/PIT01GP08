import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../firebase_options.dart';

enum SplashState { loading, logged, unlogged }

class SplashController extends Cubit<SplashState> {
  final LocalAuthentication authBio;
  SplashController({required this.authBio}) : super(SplashState.loading);

  void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(SplashState.unlogged);
    } else {
      emit(SplashState.logged);
    }
  }

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await authBio.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await authBio.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await authBio.authenticate(localizedReason: 'Autenticação manual');
  }
}
