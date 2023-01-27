abstract class MyPixKeysState {}

class LoadingMyPixKeysState extends MyPixKeysState {}

class SuccessMyPixKeysState extends MyPixKeysState {
  final Map<String, String> list;

  SuccessMyPixKeysState(this.list);
}

class ErrorMyPixKeysState extends MyPixKeysState {
  final String message;

  ErrorMyPixKeysState(this.message);
}

class SavingMyPixKeysState extends MyPixKeysState {}

class SavedMyPixKeysState extends MyPixKeysState {}

class SaveErrorMyPixKeysState extends MyPixKeysState {
  final String message;

  SaveErrorMyPixKeysState(this.message);
}
