import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_states.dart';

class ProfileController extends Cubit<ProfileState> {
  ProfileController() : super(LoadingProfileState()) {
    delay();
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(SuccessProfileState());
    return;
  }
}
