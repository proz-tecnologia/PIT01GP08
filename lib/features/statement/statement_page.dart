import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import '../../shared/widgets/top_bar_toggle_button.dart';
import '../../shared/widgets/month_changer.dart';
import '../module/data_controller.dart';
import '../module/data_states.dart';
import 'statement_controller.dart';
import 'statement_states.dart';
import '../../shared/widgets/transaction_tile.dart';

class StatementPage extends StatelessWidget {
  const StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StatementController(
        (context.read<DataController>().state as SuccessDataState)
            .transactionList);
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: MonthChanger((month) {}),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.text_snippet_rounded),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<StatementController, StatementState>(
            bloc: controller,
            builder: (context, currentState) {
              final list = controller.list;
              return Column(
                children: [
                  Row(
                    children: [
                      TopBarToggleButton.expense(
                        isSelected: currentState is BothStatementState ||
                            currentState is ExpenseStatementState,
                        onPressed: () => controller.toggleState(false),
                      ),
                      TopBarToggleButton.income(
                        isSelected: currentState is BothStatementState ||
                            currentState is IncomeStatementState,
                        onPressed: () => controller.toggleState(true),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.smallSpace),
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Card(
                          child: TransactionTile.check(list[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
