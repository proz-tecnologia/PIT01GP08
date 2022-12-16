import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../firebase_options.dart';

enum SplashState { loading, logged, unlogged }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);

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
}
