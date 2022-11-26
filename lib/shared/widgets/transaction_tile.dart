import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(
    this.transaction, {
    Key? key,
    required this.trailingCondition,
    required this.trailingIcon,
  }) : super(key: key);

  final Transaction transaction;
  final Icon trailingIcon;
  final bool trailingCondition;

  factory TransactionTile.alert(Transaction transaction) {
    return TransactionTile(
      transaction,
      trailingCondition:
          transaction.date.difference(DateTime.now()) < const Duration(days: 4),
      trailingIcon: const Icon(
        Icons.warning_rounded,
        color: AppColors.expense,
      ),
    );
  }

  factory TransactionTile.check(Transaction transaction) {
    return TransactionTile(
      transaction,
      trailingCondition: true,
      trailingIcon: const Icon(
        Icons.check_circle_rounded,
        color: AppColors.primary,
        size: Sizes.smallIconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        transaction.valueString,
        style: TextStyle(
          color: transaction.type == 'expense'
              ? AppColors.expense
              : AppColors.income,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(transaction.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${transaction.date.day}/${transaction.date.month}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
          ),
          trailingCondition ? trailingIcon : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
