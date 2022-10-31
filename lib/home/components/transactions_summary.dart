import 'package:flutter/material.dart';

import 'transaction_list_tile.dart';

class TransactionsSummary extends StatelessWidget {
  const TransactionsSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Á vencer/vencidas',
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TransactionListTile(0),
          const Divider(),
          const TransactionListTile(1),
          const Divider(),
          const TransactionListTile(2),
        ],
      ),
    );
  }
}
