import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/user.dart';
import 'register_states.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(LoadingRegisterState());

  final _users = <User>[];
  List<User> get users => _users;

  void _registerUser(User user) {}

  bool emailValid(String? email) {
    if (email == null) {
      return false;
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(p);
  }
}
