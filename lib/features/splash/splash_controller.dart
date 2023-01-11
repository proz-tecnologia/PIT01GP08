import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';

enum SplashState { loading, logged, unlogged, manualLog }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);
  final LocalAuthentication authBio = LocalAuthentication();

  void init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(SplashState.unlogged);
    } else {
      final SharedPreferences spref = await SharedPreferences.getInstance();
      final bool canAuthenticateWithBiometrics = await isBiometricAvailable();

      if (canAuthenticateWithBiometrics &&
          (spref.getBool('biometria') ?? false)) {
        final a = await authenticate();
        if (a) {
          emit(SplashState.logged);
        } else {
          emit(SplashState.manualLog);
        }
      } else {
        emit(SplashState.logged);
      }
    }
  }

// chama a autenticação se o retorno for verdadeiro
  Future<bool> authenticate() async {
    return await authBio.authenticate(
        localizedReason: 'Desbloqueie seu celular',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            biometricHint: '',
            signInTitle: 'Financial',
            cancelButton: 'Cancelar',
          ),
        ]);
  }

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await authBio.canCheckBiometrics;
    return canAuthenticateWithBiometrics && await authBio.isDeviceSupported();
  }
}
