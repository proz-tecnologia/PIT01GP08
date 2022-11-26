import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/colors.dart';
import '../statement_controller.dart';
import '../statement_states.dart';

class TopBarToggle extends StatelessWidget {
  const TopBarToggle(
    this.text, {
    Key? key,
    required this.color,
    required this.isIncome,
  }) : super(key: key);

  final String text;
  final Color color;
  final bool isIncome;

  factory TopBarToggle.expense() {
    return const TopBarToggle(
      'DESPESA',
      color: AppColors.expense,
      isIncome: false,
    );
  }

  factory TopBarToggle.income() {
    return const TopBarToggle(
      'RECEITA',
      color: AppColors.income,
      isIncome: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<StatementController>();
    return BlocBuilder<StatementController, StatementState>(
      builder: (context, state) {
        final selected = state is BothStatementState ||
            (isIncome
                ? state is IncomeStatementState
                : state is ExpenseStatementState);
        return Expanded(
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => controller.toggleState(isIncome),
                style: TextButton.styleFrom(
                  foregroundColor: selected ? color : AppColors.darkGrey,
                ),
                child: Text(text),
              ),
            ),
            selected
                ? Container(
                    color: color,
                    height: 2,
                  )
                : const SizedBox.shrink(),
          ]),
        );
      },
    );
  }
}
