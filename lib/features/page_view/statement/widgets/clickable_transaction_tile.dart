import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/colors.dart';
import '../../../../design_sys/sizes.dart';
import '../../../../shared/models/transaction.dart';
import '../../data_controller.dart';
import '../../data_states.dart';
import '../../widgets/transaction_tile.dart';
import '../statement_controller.dart';

class ClickableTransactionTile extends StatelessWidget {
  const ClickableTransactionTile(this.transaction, {super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final items = [
      PopupMenuItem(
        onTap: () {
          context.read<DataController>().fulfillTransaction(transaction);
          context.read<StatementController>().fulfillOnScreen(transaction);
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
              style: TextStyle(color: AppColors.income),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        onTap: () => Future(
          () => Navigator.of(context).pushNamed(
            '/new-entry',
            arguments: [
              (context.read<DataController>().state as SuccessDataState)
                  .categoryList,
              transaction,
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
          context.read<DataController>().deleteTransaction(transaction);
          context.read<StatementController>().deleteFromScreen(transaction);
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
              style: TextStyle(color: AppColors.expense),
            ),
          ],
        ),
      ),
    ];
    if (transaction.isCopy ?? false) {
      items.removeAt(1);
    }
    return Card(
      child: PopupMenuButton(
        itemBuilder: (context) => items,
        child: TransactionTile.check(transaction),
      ),
    );
  }
}
