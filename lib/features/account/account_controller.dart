import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'account_states.dart';

class AccountController extends Cubit<AccountState> {
  AccountController() : super(LoadingAccountState());

  final photo = ValueNotifier(FirebaseAuth.instance.currentUser?.photoURL);
  final emailVerified =
      ValueNotifier(FirebaseAuth.instance.currentUser?.emailVerified ?? false);

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
        photo.value = pickedFile.path;
        emit(SuccessAccountState('Foto atualizada com sucesso!'));
      }
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar foto'));
    }
  }

  void updateName(String name) async {
    emit(LoadingAccountState());
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      emit(SuccessAccountState('Nome atualizado com sucesso!'));
    } catch (e) {
      emit(ErrorAccountState('Erro ao atualizar o nome do usuário'));
    }
  }

  void updateEmail(String email) async {
    emit(LoadingAccountState());
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      emailVerified.value =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      emit(SuccessAccountState(
          'Email atualizado com sucesso!\nVerifique seu email (e a caixa de spam).'));
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
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
      emit(SuccessAccountState('Senha atualizada com sucesso!'));
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'weak-password':
            emit(ErrorAccountState(
                'Sua senha precisa ter pelo menos 6 caracteres'));
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

  void verifyEmail() async {
    try {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      emit(SuccessAccountState(
          'O link de verificação foi enviado para ${FirebaseAuth.instance.currentUser?.email}'));
    } catch (e) {
      emit(ErrorAccountState('Erro de conexão'));
    }
  }

  void deleteUser() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .delete();
      FirebaseAuth.instance.currentUser?.delete();
      FirebaseAuth.instance.signOut();
      emit(LoggedOutAccountState());
    } catch (e) {
      emit(ErrorAccountState('Não foi possível excluir a conta'));
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
