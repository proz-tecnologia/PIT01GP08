import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/colors.dart';
import '../../../../design_sys/sizes.dart';
import '../home_controller.dart';
import '../home_states.dart';
import 'pending_card.dart';

class AppPending extends StatelessWidget {
  const AppPending({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        if (state is ErrorHomeState) {
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
                    value: 'R\$ ${state.pendingExpenseStr}',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PendingCard(
                    color: AppColors.income,
                    icon: Icons.publish_rounded,
                    label: 'A receber',
                    value: 'R\$ ${state.pendingIncomeStr}',
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
