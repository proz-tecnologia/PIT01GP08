import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/user.dart';
import 'register_states.dart';

class RegisterController extends Cubit<RegisterState> {
  RegisterController() : super(LoadingRegisterState());

  final _users = <User>[];
  List<User> get users => _users;

  Future<void> registerUser(User user) async {
    emit(LoadingRegisterState());

    await Future.delayed(const Duration(seconds: 2));
    // verificar se o email já está cadastrado.
    if (user.email == 'jackson@gmail.com') {
      emit(ErrorRegisterState('email já cadastrado'));
      return;
    } else {
      emit(SuccessRegisterState());
    }
  }
}
