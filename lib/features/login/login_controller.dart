import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/shared_preferences_keys.dart';
import 'login_states.dart';

class LoginController {
  Future<LoginState> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (email == 'ruda@gmail.com' && password == '12345678') {
      prefs.setBool(SharedPreferencesKeys.userLogged, true);
      return LoginStateSuccess();
    }
    return LoginStateError('senha invalida');
  }
}
