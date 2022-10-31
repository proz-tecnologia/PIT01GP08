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
