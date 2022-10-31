import 'package:flutter/material.dart';

import '../components/pending_card.dart';
import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';

class AppPending extends StatelessWidget {
  const AppPending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.smallSpace),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: PendingCard(
              icon: Icons.download_rounded,
              color: AppColors.expense,
              label: 'A pagar',
              value: 'R\$ 1000,00',
            ),
          ),
          Expanded(
            flex: 1,
            child: PendingCard(
              color: AppColors.income,
              icon: Icons.publish_rounded,
              label: 'A receber',
              value: 'R\$ 1000,00',
            ),
          ),
        ],
      ),
    );
  }
}
