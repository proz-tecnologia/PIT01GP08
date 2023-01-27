import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/colors.dart';
import '../../../../design_sys/sizes.dart';
import '../home_controller.dart';
import '../home_states.dart';

class PendingCard extends StatelessWidget {
  const PendingCard._({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  factory PendingCard.expense() {
    return const PendingCard._(
      icon: Icons.arrow_circle_down_rounded,
      color: AppColors.expense,
      label: 'A pagar',
    );
  }

  factory PendingCard.income() {
    return const PendingCard._(
      color: AppColors.income,
      icon: Icons.arrow_circle_up_rounded,
      label: 'A receber',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.mediumSpace),
        child: Column(
          children: [
            Icon(
              icon,
              size: Sizes.largeIconSize,
              color: color,
            ),
            Text(label),
            BlocBuilder<HomeController, HomeState>(
              builder: (context, state) {
                if (state is SuccessHomeState) {
                  return ValueListenableBuilder(
                      valueListenable: context.read<HomeController>().isVisible,
                      builder: (_, isVisible, __) {
                        return Text(
                          isVisible
                              ? color == AppColors.expense
                                  ? state.pendingExpenseStr
                                  : state.pendingIncomeStr
                              : 'R\$ -------',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        );
                      });
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SizedBox(
                    width: Sizes.extraLargeIconSize,
                    child: LinearProgressIndicator(
                      minHeight: Sizes.smallSpace,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      backgroundColor:
                          Theme.of(context).dividerColor.withOpacity(0.2),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
