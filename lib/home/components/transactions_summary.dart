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
        children: const [
          TransactionListTile(0),
          Divider(),
          TransactionListTile(1),
          Divider(),
          TransactionListTile(2),
        ],
      ),
    );
  }
}
