import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_states.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(LoadingRegisterState());

  // final _users = <User>[];
  // List<User> get users => _users;

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(LoadingRegisterState());

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SuccessRegisterState());
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {
          emit(ErrorRegisterState(
              'Email já cadastrado, se esqueceu a senha, recupera sua senha'));
        }
        if (e.code == "invalid-email") {
          emit(ErrorRegisterState('Esse email não é válido'));
        }
        log(e.message ?? 'FirebaseAuthException');
        //emit(ErrorRegisterState(e.message ?? 'Error on registerController'));
      }
    }
  }
}
