import 'package:financial_app/design_sys/colors.dart';
import 'package:financial_app/design_sys/sizes.dart';
import 'package:financial_app/features/home/home_controller.dart';
import 'package:financial_app/features/home/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../statement/statement_states.dart';
import 'pending_card.dart';

class AppPending extends StatelessWidget {
  const AppPending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        final controller = context.read<HomeController>();
        if (state is ErrorStatementState) {
          return const Center(child: Text('Erro ao carregar os dados'));
        }
        if (state is SuccessHomeState) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.smallSpace),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: PendingCard(
                    icon: Icons.download_rounded,
                    color: AppColors.expense,
                    label: 'A pagar',
                    value:
                        'R\$ ${controller.displayBalance('pendingExpense').toStringAsFixed(2).replaceAll('.', ',')}',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PendingCard(
                    color: AppColors.income,
                    icon: Icons.publish_rounded,
                    label: 'A receber',
                    value:
                        'R\$ ${controller.displayBalance('pendingIncome').toStringAsFixed(2).replaceAll('.', ',')}',
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
