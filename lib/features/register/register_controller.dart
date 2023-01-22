import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/category_repository.dart';
import 'register_states.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController(this.categoryRepo) : super(LoadingRegisterState());

  final CategoryRepository categoryRepo;

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    emit(LoadingRegisterState());

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser!.updateDisplayName(name);
      await categoryRepo.setInitialCategories(auth.currentUser!.uid);

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
      } else {
        emit(ErrorRegisterState('Erro de conexão, tente novamente!'));
      }
    }
  }

  Future<void> googleSignUp() async {
    emit(LoadingRegisterState());
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
      final firstLog =
          await categoryRepo.checkFirstAccess(verify.user?.uid ?? 'no user');
      if (firstLog) {
        await categoryRepo.setInitialCategories(verify.user!.uid);
      }
      if (verify.user != null) {
        emit(SuccessRegisterState());
      }
    } catch (e) {
      emit(ErrorRegisterState("Erro no login com Google"));
    }
  }
}
