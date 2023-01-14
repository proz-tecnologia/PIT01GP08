abstract class AccountState {}

class LoadingAccountState implements AccountState {}

class SuccessAccountState implements AccountState {
  final String? message;

  SuccessAccountState([this.message]);
}

class ErrorAccountState implements AccountState {
  final String error;

  ErrorAccountState(this.error);
}
