import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/views/error_view.dart';
import '../../shared/views/loading_view.dart';
import 'new_entry_content.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Nova transação')),
        body: BlocConsumer<NewEntryController, NewEntryState>(
          listener: (context, currentState) {
            if (currentState is SavingErrorNewEntryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ocorreu um erro. Tente novamente.'),
                ),
              );
            }
            if (currentState is SuccessNewEntryState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transação salva com sucesso.'),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, currentState) {
            if (currentState is ErrorNewEntryState) {
              return const ErrorView(
                icon: Icons.cloud_off_rounded,
                text: 'Ocorreu um erro.\nTente novamente.',
              );
            }
            if (currentState is NewEntryTypeState) {
              return const NewEntryContent();
            }
            return const LoadingView();
          },
        ),
      ),
    );
  }
}
