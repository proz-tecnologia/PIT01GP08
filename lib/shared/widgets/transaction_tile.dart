import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

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
                ?.copyWith(
                    color: Theme.of(context)
                        .secondaryHeaderColor),
          ),
          Icon(
            Icons.check_circle_rounded,
            color: Theme.of(context).primaryColor,
            size: Sizes.smallIconSize,
          )
        ],
      ),
    );
  }
}
