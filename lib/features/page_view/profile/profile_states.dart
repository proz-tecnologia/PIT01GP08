import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileState {}

class LoadingProfileState implements ProfileState {}

class SuccessProfileState implements ProfileState {
  final User user;

  SuccessProfileState(this.user);
}

class ErrorProfileState implements ProfileState {
  final String error;

  ErrorProfileState(this.error);
}
