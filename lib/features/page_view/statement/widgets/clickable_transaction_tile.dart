import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/colors.dart';
import '../../../../shared/models/category.dart';
import '../../../../shared/models/transaction.dart';
import '../../data_controller.dart';
import '../../data_states.dart';
import '../../widgets/transaction_tile.dart';
import '../statement_controller.dart';

class ClickableTransactionTile extends StatelessWidget {
  const ClickableTransactionTile(
    this.transaction, {
    super.key,
    required this.category,
  });

  final Transaction transaction;
  final Category category;

  @override
  Widget build(BuildContext context) {
    final items = [
      Expanded(
        child: IconButton(
          onPressed: () {
            context.read<DataController>().fulfillTransaction(transaction);
            context.read<StatementController>().fulfillOnScreen(transaction);
          },
          icon: const Icon(
            Icons.attach_money,
            color: AppColors.income,
          ),
          tooltip: 'Pagar',
        ),
      ),
      Expanded(
        child: IconButton(
          onPressed: () => Navigator.of(context).pushNamed(
            '/new-entry',
            arguments: [
              (context.read<DataController>().state as SuccessDataState)
                  .categoryList,
              transaction,
            ],
          ),
          icon: const Icon(Icons.edit_rounded),
          tooltip: 'Editar',
        ),
      ),
      Expanded(
        child: IconButton(
          onPressed: () {
            context.read<DataController>().deleteTransaction(transaction);
            context.read<StatementController>().deleteFromScreen(transaction);
          },
          icon: const Icon(
            Icons.delete_rounded,
            color: AppColors.expense,
          ),
          tooltip: 'Excluir',
        ),
      ),
    ];
    if (transaction.isCopy ?? false) {
      items.removeAt(1);
    }
    return Card(
      child: TransactionTile.check(
        transaction,
        category: category,
        actions: items,
      ),
    );
  }
}
