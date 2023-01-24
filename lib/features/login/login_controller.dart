import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/category_repository.dart';
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
        switch (e.code) {
          case 'invalid-email':
          case 'wrong-password':
            emit(LoginStateError('Email e/ou senha inválidos'));
            break;
          case 'user-disabled':
            emit(LoginStateError('Este usuário foi desabilitado'));
            break;
          case 'user-not-found':
            emit(LoginStateError('Usuário não encontrado'));
            break;
          default:
            emit(LoginStateError('Erro de conexão'));
        }
      } else {
        emit(LoginStateError('Erro de conexão'));
      }
    }
  }

  Future<void> googleSignIn() async {
    emit(LoginStateLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final verify =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firstLog = await CategoryFirebaseRepository(
        FirebaseFirestore.instance,
        FirebaseAuth.instance.currentUser?.uid ?? 'no user',
      ).checkFirstAccess(verify.user?.uid ?? 'no user');
      if (firstLog) {
        throw Exception();
      }
      if (verify.user != null) {
        emit(LoginStateSuccess());
      }
    } catch (e) {
      emit(LoginStateError("Erro no login com Google"));
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
