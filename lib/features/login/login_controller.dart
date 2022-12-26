import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../shared/shared_preferences_keys.dart';
import 'login_states.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginStateLoading());

  Future<void> login(String email, String password) async {
    emit(LoginStateLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      print(user.toString());
      emit(LoginStateSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'network-request-failed') {
          emit(
            LoginStateError('Sem conexão com internet'),
          );
        } else {
          print(e.toString());
          log(e.message ?? 'FirebaseAuthException');
          print('CODIGO');
          print(e.code);
          emit(
            LoginStateError(e.message ?? 'Error on loginController'),
          );
        }
      }
    }
  }
}
