import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_states.dart';

class ProfileController extends Cubit<ProfileState> {
  ProfileController() : super(LoadingProfileState()) {
    getAllInfosfromUser();
  }

  void getAllInfosfromUser() {
    emit(LoadingProfileState());
    try {
      User userInfo = FirebaseAuth.instance.currentUser!;
      emit(SuccessProfileState(userInfo));
      userInfo;
    } catch (e) {
      emit(ErrorProfileState('Erro de conexão, tente novamente!'));
    }
  }
}
