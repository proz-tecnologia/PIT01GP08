import 'package:flutter/material.dart';

import '../../design_sys/sizes.dart';
import 'transaction_list_tile.dart';

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
