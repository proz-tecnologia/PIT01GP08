abstract class SettingsState {}

class LoadingSettingsState implements SettingsState {}

class SuccessSettingsState implements SettingsState {
  final bool bioAvailable;

  SuccessSettingsState(this.bioAvailable);
}

class ErrorSettingsState implements SettingsState {
  final String error;

  ErrorSettingsState(this.error);
}
