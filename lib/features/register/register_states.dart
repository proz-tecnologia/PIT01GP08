abstract class RegisterState {}

class LoadingRegisterState implements RegisterState {}

class SuccessRegisterState implements RegisterState {}

class ErrorRegisterState implements RegisterState {
  final String error;

  ErrorRegisterState(this.error);
}
