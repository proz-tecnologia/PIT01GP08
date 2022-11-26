import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'statement_controller.dart';
import 'statement_states.dart';
import 'widgets/topbar_button.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatementController, StatementState>(
      builder: (context, currentState) {
        if (currentState is LoadingStatementState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (currentState is ErrorStatementState) {
          return const Center(child: Text('Erro'));
        }
        final list = context.read<StatementController>().list;
        return SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  TopBarToggle.expense(),
                  TopBarToggle.income(),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(list[index].valueString),
                            subtitle: Text(list[index].description),
                          ),
                        )),
              ),
            ],
          ),
        );
      },
    );
  }
}
