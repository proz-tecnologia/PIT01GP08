import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page_view/shared/models/category.dart';
import '../page_view/shared/repositories/transaction_repository.dart';
import 'new_entry_content.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage(this.categoryList, {super.key});
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            NewEntryController(TransactionFirebaseRepository()),
        child: Scaffold(
          appBar: AppBar(title: const Text('Nova transação')),
          body: BlocConsumer<NewEntryController, NewEntryState>(
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
                    .pushNamedAndRemoveUntil('/home-page', (route) => false);
              }
            },
            builder: (context, currentState) {
              return NewEntryContent(categoryList);
            },
          ),
        ),
      ),
    );
  }
}
