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
      emit(ErrorAccountState('Erro ao atualizar a imagem'));
    }
  }

  void updateName(String name) {
    try {
      FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar o nome do usuário'));
    }
  }

  // TODO: tratar FirebaseAuthException's
  void updateEmail(String email) {
    try {
      FirebaseAuth.instance.currentUser?.updateEmail(email);
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar o email do usuário'));
    }
  }

  // TODO: tratar FirebaseAuthException's
  void updatePassword(String password) {
    try {
      FirebaseAuth.instance.currentUser?.updatePassword(password);
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar o email do usuário'));
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
