import 'package:financial_app/features/splash/widgets/app_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings_controller.dart';
import '../settings_states.dart';

class SelecConfBio extends StatelessWidget {
  const SelecConfBio({Key? key, required this.titleSelected}) : super(key: key);

  final String titleSelected;

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController();

    return BlocBuilder<SettingsController, SettingsState>(
      bloc: controller,
      builder: (context, state) {
        if (state is SuccessSettingsState) {
          return ValueListenableBuilder(
              valueListenable: controller.select,
              builder: (context, value, _) {
                return SwitchListTile(
                  selected: false,
                  title: Text(titleSelected),
                  value: value,
                  onChanged: state.bioAvailable
                      ? (value) {
                          controller.select.value = value;
                          controller.setConfBiometria(value);
                          //state.spref.setBool('biometria', value);
                        }
                      : null,
                );
              });
        } else {
          return const AppProgress();
        }
      },
    );
  }
}
