abstract class ProfileState {}

class LoadingProfileState implements ProfileState {}

class SuccessProfileState implements ProfileState {}

class ErrorProfileState implements ProfileState {
  final String error;

  ErrorProfileState(this.error);
}
