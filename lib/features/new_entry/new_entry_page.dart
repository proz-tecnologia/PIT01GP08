import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../services/transaction_repository.dart';
import 'new_entry_content.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NewEntryController(TransactionFirebaseRepository());
    final categoryList = 
        (ModalRoute.of(context)?.settings.arguments as List)[0] as List<Category>;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Nova transação')),
        body: BlocListener<NewEntryController, NewEntryState>(
          bloc: controller,
          listener: (context, currentState) {
            if (currentState is ErrorNewEntryState) {
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
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            }
          },
          child: BlocProvider(
            create: (context) => controller,
            child: NewEntryContent(categoryList),
          ),
        ),
      ),
    );
  }
}
