import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';
import '../../../models/transaction.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mySummary[index].value,
        style: const TextStyle(
          color: AppColors.expense,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        mySummary[index].description,
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${mySummary[index].date.day}/${mySummary[index].date.month}',
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          ),
          mySummary[index].date.difference(DateTime.now()) <
                  const Duration(days: 4)
              ? const Icon(
                  Icons.warning_rounded,
                  color: AppColors.expense,
                )
              : Container(),
        ],
      ),
    );
  }
}


//Mocked example values
List<Transaction> mySummary = [
  Transaction(
    type: Type.expense,
    description: 'Parcela carro',
    value: 850,
    date: DateTime.now().add(
      const Duration(days: 3),
    ),
  ),
  Transaction(
    type: Type.expense,
    description: 'Conta de energia',
    value: 450,
    date: DateTime.now().add(
      const Duration(days: 10),
    ),
  ),
  Transaction(
    type: Type.expense,
    description: 'Remédios',
    value: 23.90,
    date: DateTime.now().add(
      const Duration(days: 12),
    ),
  ),
];
