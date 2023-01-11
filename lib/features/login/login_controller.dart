import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      } else {
        emit(LoginStateError('Erro de conexão'));
      }
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Email enviado para $email.\nPor favor, verifique sua caixa de entrada (e a pasta spam).';
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'missing-email':
            emit(LoginStateError('Por favor, digite seu email.'));
            break;
          case 'invalid-email':
            emit(LoginStateError('Email inválido: $email'));
            break;
          case 'user-not-found':
            emit(LoginStateError(
                'Não foi encontrado nenhum usuário com o email $email'));
            break;
          default:
            emit(LoginStateError(
                'Algo deu errado.\nDigite novamente seu email e tente novamente.'));
        }
      } else {
        emit(LoginStateError('Erro de conexão'));
      }
      return null;
    }
  }
}
