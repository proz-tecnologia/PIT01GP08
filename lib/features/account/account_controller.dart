import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_states.dart';

class AccountController extends Cubit<AccountState> {
  AccountController() : super(LoadingAccountState()) {
    getAllInfosfromUser();
  }

  void getAllInfosfromUser() {
    emit(LoadingAccountState());
    try {
      User userInfo = FirebaseAuth.instance.currentUser!;
      emit(SuccessAccountState(userInfo));
      userInfo;
    } catch (e) {
      emit(ErrorAccountState('Erro de conexão, tente novamente!'));
    }
  }
}
