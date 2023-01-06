import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'account_states.dart';

class AccountController extends Cubit<AccountState> {
  AccountController() : super(LoadingAccountState()) {
    getAllInfosfromUser();
  }

  void getAllInfosfromUser() {
    emit(LoadingAccountState());
    try {
      User userInfo = FirebaseAuth.instance.currentUser!;
      emit(SuccessAccountState(userInfo));
      userInfo;
    } catch (e) {
      emit(ErrorAccountState('Erro de conexão, tente novamente!'));
    }
  }

  void updateImage() async {
    try {
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      emit(LoadingAccountState());
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("user/${FirebaseAuth.instance.currentUser!.uid}/image");
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await firebaseStorageRef.putFile(file);
        final downloadUrl = await firebaseStorageRef.getDownloadURL();
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
      }
      emit(SuccessAccountState(FirebaseAuth.instance.currentUser!));
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar foto'));
    }
  }

  void updateName(String name) async {
    emit(LoadingAccountState());
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      emit(SuccessAccountState(FirebaseAuth.instance.currentUser!));
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar o nome do usuário'));
    }
  }

  void updateEmail(String email) async {
    emit(LoadingAccountState());
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      emit(SuccessAccountState(FirebaseAuth.instance.currentUser!));
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.message) {
          case 'invalid-email':
            emit(ErrorAccountState('E-mail inválido'));
            break;
          case 'email-already-in-use':
            emit(ErrorAccountState('Este e-mail já está sendo utilizado'));
            break;
          case 'requires-recent-login':
            emit(ErrorAccountState(
                'Esta alteração requer login recente.\nFaça login novamente para atualizar.'));
            break;
          default:
            emit(ErrorAccountState('Erro ao atualizar o email'));
        }
      } else {
        emit(ErrorAccountState('Erro de conexão'));
      }
    }
  }

  void updatePassword(String password) async {
    emit(LoadingAccountState());
    try {
      await FirebaseAuth.instance.currentUser?.updatePassword(password);
      emit(SuccessAccountState(FirebaseAuth.instance.currentUser!));
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.message) {
          case 'weak-password':
            emit(ErrorAccountState('Sua senha precisa ter pelo menos 6 caracteres'));
            break;
          case 'requires-recent-login':
            emit(ErrorAccountState(
                'Esta alteração requer login recente.\nFaça login novamente para atualizar.'));
            break;
          default:
            emit(ErrorAccountState('Erro ao atualizar a senha'));
        }
      } else {
        emit(ErrorAccountState('Erro de conexão'));
      }
      
    }
  }

  // void updatePhoneNumber(String value) {
  //   FirebaseAuth.instance.verifyPhoneNumber(
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   FirebaseAuth.instance.currentUser?.updatePhoneNumber();
  //   return;
  // }
}
