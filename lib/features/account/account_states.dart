import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountState {}

class LoadingAccountState implements AccountState {}

class SuccessAccountState implements AccountState {
  final User user;

  SuccessAccountState(this.user);
}

class ErrorAccountState implements AccountState {
  final String error;

  ErrorAccountState(this.error);
}
