import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/shared_preferences_keys.dart';
import 'login_states.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginStateLoading());

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    emit(LoginStateLoading());

    if (email == 'ruda@gmail.com' && password == '12345678') {
      prefs.setBool(SharedPreferencesKeys.userLogged, true);
      emit(LoginStateSuccess());
      return;
    }
    emit(LoginStateError('senha invalida'));
  }
}
