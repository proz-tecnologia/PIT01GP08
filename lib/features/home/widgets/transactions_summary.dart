import 'package:financial_app/design_sys/sizes.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:financial_app/shared/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionsSummary extends StatelessWidget {
  const TransactionsSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.mediumSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A vencer/vencidas',
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          TransactionTile.alert(
            Transaction(
              type: Type.expense,
              description: 'Parcela carro',
              value: 850,
              date: DateTime.now().add(
                const Duration(days: 3),
              ),
              categoryId: 1,
              fulfilled: true,
              payment: Payment.normal,
            ),
          ),
          const Divider(),
          TransactionTile.alert(
            Transaction(
              type: Type.expense,
              description: 'Conta de energia',
              value: 450,
              date: DateTime.now().add(
                const Duration(days: 10),
              ),
              categoryId: 1,
              fulfilled: true,
              payment: Payment.normal,
            ),
          ),
          const Divider(),
          TransactionTile.alert(
            Transaction(
              type: Type.expense,
              description: 'Remédios',
              value: 23.90,
              date: DateTime.now().add(
                const Duration(days: 12),
              ),
              categoryId: 1,
              fulfilled: true,
              payment: Payment.normal,
            ),
          ),
        ],
      ),
    );
  }
}
