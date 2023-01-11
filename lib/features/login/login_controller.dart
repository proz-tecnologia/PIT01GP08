import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_states.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(LoginStateLoading());

  Future<void> login(String email, String password) async {
    emit(LoginStateLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginStateSuccess());
    } catch (e) {
      if (e is FirebaseAuthException) {
        log(e.message ?? 'FirebaseAuthException');
        emit(LoginStateError(e.message ?? 'Error on loginController'));
      }
    }
  }

  Future<void> googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );
          emit(LoginStateSuccess());
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(LoginStateError(e.message ?? 'Error on loginController'));
          }
        }
      }
    }
  }
}
