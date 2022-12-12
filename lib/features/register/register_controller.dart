import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/user.dart';
import 'register_states.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(LoadingRegisterState());

  // final _users = <User>[];
  // List<User> get users => _users;

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(LoadingRegisterState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await Future.delayed(const Duration(seconds: 2));
    // verificar se o email já está cadastrado.
    // if (user.email == 'jackson@gmail.com') {
      if (false) {
      emit(ErrorRegisterState('email já cadastrado'));
      return;
    } else {
      emit(SuccessRegisterState());
      return;
    }
  }
}
