import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
