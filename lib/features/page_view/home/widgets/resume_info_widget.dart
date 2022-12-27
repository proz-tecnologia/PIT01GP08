import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../design_sys/sizes.dart';
import '../home_controller.dart';
import '../home_states.dart';
import 'total_tile.dart';

class ResumeInfoWidget extends StatefulWidget {
  const ResumeInfoWidget({super.key});

  @override
  State<ResumeInfoWidget> createState() => _ResumeInfoWidgetState();
}

class _ResumeInfoWidgetState extends State<ResumeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final spaceBetween = height * Sizes.threePercent;

    return Container(
      margin: EdgeInsets.only(bottom: spaceBetween),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: BlocBuilder<HomeController, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: spaceBetween),
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                SizedBox(height: spaceBetween),
                Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    TotalTile(
                      label: 'Saldo',
                      value:
                          state is SuccessHomeState ? state.balanceStr : null,
                    ),
                    Expanded(
                      flex: 1,
                      child: ValueListenableBuilder(
                        valueListenable:
                            context.read<HomeController>().isVisible,
                        builder: (context, value, _) {
                          return IconButton(
                            onPressed: () => context
                                .read<HomeController>()
                                .isVisible
                                .value = !value,
                            icon: Icon(
                              value ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spaceBetween),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TotalTile(
                      icon: Icons.arrow_downward,
                      label: 'Despesas',
                      value:
                          state is SuccessHomeState ? state.expenseStr : null,
                    ),
                    TotalTile(
                      icon: Icons.arrow_upward,
                      label: 'Receitas',
                      value: state is SuccessHomeState ? state.incomeStr : null,
                    ),
                  ],
                ),
                SizedBox(height: spaceBetween),
              ],
            );
          },
        ),
      ),
    );
  }
}
