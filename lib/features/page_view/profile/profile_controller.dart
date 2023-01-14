import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  void signOut() async {
    emit(LoadingProfileState());
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      emit(LoggedOutProfileState());
    } catch (e) {
      emit(ErrorProfileState('Erro ao realizar seu logout, tente novamente!'));
    }
  }
}
