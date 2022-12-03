import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/shared_preferences_keys.dart';
import 'splash_states.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(LoadingSplashState()) {
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final logged = prefs.getBool(SharedPreferencesKeys.userLogged) ?? false;

    if (logged) {
      emit(LoggedSplashState());
      return;
    }
    emit(UnloggedSplashState());
  }
}
