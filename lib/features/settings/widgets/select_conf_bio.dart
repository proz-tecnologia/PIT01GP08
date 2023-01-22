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

    return BlocConsumer<SettingsController, SettingsState>(
      bloc: controller,
      listener: (context, state) {
        if (state is ErrorSettingsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is SuccessSettingsState) {
          return ValueListenableBuilder(
              valueListenable: controller.select,
              builder: (context, value, _) {
                return SwitchListTile(
                  title: Text(titleSelected),
                  value: value,
                  onChanged: state.bioAvailable
                      ? (value) {
                          controller.select.value = value;
                          controller.setConfBiometria(value);
                        }
                      : null,
                );
              });
        }
        if (state is ErrorSettingsState) {
          return SwitchListTile(
            title: Text(titleSelected),
            value: false,
            onChanged: null,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
