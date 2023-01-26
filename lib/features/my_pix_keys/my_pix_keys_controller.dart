import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/pix_repository.dart';
import 'my_pix_keys_states.dart';

class MyPixKeysController extends Cubit<MyPixKeysState> {
  factory MyPixKeysController.instance(PixRepository repository) =>
      MyPixKeysController._(repository);

  MyPixKeysController._(this.repository) : super(LoadingMyPixKeysState()) {
    init();
  }

  final PixRepository repository;

  void init() async {
    emit(LoadingMyPixKeysState());
    try {
      final list = await repository.getAllPixKeys();
      emit(SuccessMyPixKeysState(list));
    } catch (e) {
      emit(ErrorMyPixKeysState('Não foi possível\ncarregar os dados.'));
    }
  }

  void saveKey(
    String description, {
    required String pixKey,
  }) async {
    Map<String, String> list = (state as SuccessMyPixKeysState).list;
    emit(SavingMyPixKeysState());
    try {
      final newKey = {description: pixKey};
      await repository.setPixKey(newKey);
      list.update(description, (value) => pixKey, ifAbsent: () => pixKey);

      emit(SavedMyPixKeysState());
      emit(SuccessMyPixKeysState(list));
    } catch (e) {
      emit(SaveErrorMyPixKeysState('Algo deu errado. Tente novamente.'));
    }
  }

  void deleteCategory(String description) async {
    Map<String, String> list = (state as SuccessMyPixKeysState).list;
    try {
      await repository.deletePixKey(description);
      list.removeWhere((key, value) => key == description);
      emit(SuccessMyPixKeysState(list));
    } catch (e) {
      emit(SaveErrorMyPixKeysState('Algo deu errado. Tente novamente.'));
    }
  }
}
