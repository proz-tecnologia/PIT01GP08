import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../../shared/models/category.dart';
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
      trailingCondition: transaction.date.isBefore(DateTime.now()),
      trailingIcon: const Icon(
        Icons.warning_rounded,
        color: AppColors.expense,
      ),
    );
  }

  factory TransactionTile.check(Transaction transaction) {
    return TransactionTile(
      transaction,
      trailingCondition: transaction.fulfilled,
      trailingIcon: const Icon(
        Icons.check_circle_rounded,
        color: AppColors.primary,
        size: Sizes.smallIconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Icon trailingIconCopy = trailingIcon;
    if (trailingIcon.color == AppColors.primary &&
        Theme.of(context).brightness == Brightness.dark) {
      trailingIconCopy = Icon(
        trailingIcon.icon,
        color: AppColors.primaryOnDark,
        size: trailingIcon.size,
        semanticLabel: trailingIcon.semanticLabel,
        textDirection: trailingIcon.textDirection,
        shadows: trailingIcon.shadows,
      );
    }
    return ListTile(
      title: Text(
        transaction.valueString,
        style: TextStyle(
          color: transaction.type == Type.expense
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
          trailingCondition
              ? Padding(
                  padding: const EdgeInsets.only(left: Sizes.smallSpace),
                  child: trailingIconCopy,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
