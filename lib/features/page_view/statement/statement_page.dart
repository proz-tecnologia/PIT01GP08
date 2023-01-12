import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/colors.dart';
import '../../../design_sys/sizes.dart';
import '../../../shared/views/empty_view.dart';
import '../data_controller.dart';
import '../data_states.dart';
import '../widgets/month_changer.dart';
import '../widgets/top_bar_toggle_button.dart';
import '../widgets/transaction_tile.dart';
import 'statement_controller.dart';
import 'statement_states.dart';

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
              onPressed: () {},
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
                          : ListView.builder(
                              itemCount: state.list.length,
                              itemBuilder: (context, index) => Card(
                                child: PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        context
                                            .read<DataController>()
                                            .fulfillTransaction(
                                                state.list[index]);
                                        controller
                                            .fulfillOnScreen(state.list[index]);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.attach_money,
                                            color: AppColors.income,
                                          ),
                                          SizedBox(width: Sizes.mediumSpace),
                                          Text(
                                            'Efetuar pagamento',
                                            style: TextStyle(
                                                color: AppColors.income),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () => Future(
                                        () => Navigator.of(context).pushNamed(
                                          '/new-entry',
                                          arguments: [
                                            (context
                                                    .read<DataController>()
                                                    .state as SuccessDataState)
                                                .categoryList,
                                            state.list[index],
                                          ],
                                        ),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.edit_rounded),
                                          SizedBox(width: Sizes.mediumSpace),
                                          Text('Editar'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        context
                                            .read<DataController>()
                                            .deleteTransaction(
                                                state.list[index]);
                                        controller.deleteFromScreen(
                                            state.list[index]);
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColors.expense,
                                          ),
                                          SizedBox(width: Sizes.mediumSpace),
                                          Text(
                                            'Deletar',
                                            style: TextStyle(
                                                color: AppColors.expense),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child:
                                      TransactionTile.check(state.list[index]),
                                ),
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
