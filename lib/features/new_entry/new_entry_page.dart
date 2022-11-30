import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            if (currentState is SavingNewEntryState) {
              //esmaecer tela e chamar progress
            }
            if (currentState is SavingErrorNewEntryState) {
              //chamar snackbar
            }
            if (currentState is SuccessNewEntryState) {
              Navigator.of(context).pop();
              //chamar snackbar
            }
          },
          builder: (context, currentState) {
            if (currentState is ErrorNewEntryState) {
              return const Center(
                child: Text('Erro'),
              );
            }
            if (currentState is NewEntryTypeState) {
              return const NewEntryContent();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
