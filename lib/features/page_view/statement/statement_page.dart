import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import '../../../shared/views/empty_view.dart';
import '../data_controller.dart';
import '../data_states.dart';
import '../widgets/month_changer.dart';
import '../widgets/top_bar_toggle_button.dart';
import 'statement_controller.dart';
import 'statement_states.dart';
import 'widgets/clickable_transaction_tile.dart';

class StatementPage extends StatelessWidget {
  const StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = StatementController(
        (context.read<DataController>().state as SuccessDataState)
            .transactionList);
    controller.showTransactions(DateTime.now());
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: MonthChanger((month) => controller.showTransactions(month)),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(
                      child: Text(
                        'DEZEMBRO',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Saldo anterior: '),
                            Text('R\$ 1000,00'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Receitas:'),
                            Text('R\$ 4000,00'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Despesas:'),
                            Text('- R\$ 4000,00'),
                          ],
                        ),
                        SizedBox(
                          height: Sizes.mediumSpace,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Saldo parcial:'),
                            Text('- R\$ 4000,00'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Saldo total:'),
                            Text(' - R\$ 4000,00'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.text_snippet_rounded),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<StatementController, StatementState>(
            bloc: controller,
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      TopBarToggleButton.expense(
                        isSelected: state is BothStatementState ||
                            state is ExpenseStatementState,
                        onPressed: () => controller.toggleState(false),
                      ),
                      TopBarToggleButton.income(
                        isSelected: state is BothStatementState ||
                            state is IncomeStatementState,
                        onPressed: () => controller.toggleState(true),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.smallSpace),
                      child: state.list.isEmpty
                          ? const EmptyView('Ainda não há transações nesse mês')
                          : BlocProvider(
                              create: (context) => controller,
                              child: ListView.builder(
                                itemCount: state.list.length,
                                itemBuilder: (context, index) {
                                  return ClickableTransactionTile(
                                      state.list[index]);
                                },
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
