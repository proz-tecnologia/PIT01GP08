import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
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
        if (currentState is BothStatementState) {
          final list = context.read<StatementController>().list;
          return SafeArea(
            child: Column(
              children: [
                Row(
                  children: const [
                    NewEntryTopBarItem(
                      'DESPESA',
                      color: AppColors.expense,
                    ),
                    NewEntryTopBarItem(
                      'RECEITA',
                      color: AppColors.income,
                    ),
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
        }
        if (currentState is ErrorStatementState) {
          return const Center(child: Text('Erro'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
