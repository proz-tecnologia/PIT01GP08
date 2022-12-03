import 'package:financial_app/design_sys/sizes.dart';
import 'package:financial_app/features/home/home_controller.dart';
import 'package:financial_app/features/home/home_states.dart';
import 'package:financial_app/shared/widgets/month_changer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'total_tile.dart';

class ResumeInfoWidget extends StatefulWidget {
  const ResumeInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ResumeInfoWidget> createState() => _ResumeInfoWidgetState();
}

class _ResumeInfoWidgetState extends State<ResumeInfoWidget> {
  final ValueNotifier<bool> isVisible = ValueNotifier(true);

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
            final controller = context.read<HomeController>();
            if (state is ErrorHomeState) {
              return const Center(child: Text('Erro ao carregar os dados'));
            }
            if (state is SuccessHomeState) {
              return ValueListenableBuilder(
                valueListenable: isVisible,
                builder: (context, value, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: spaceBetween),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          MonthChanger('Dezembro'),
                        ],
                      ),
                      SizedBox(height: spaceBetween),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Container()),
                          TotalTile(
                            label: 'Saldo',
                            value:
                                'R\$ ${controller.displayBalance('balance').toStringAsFixed(2).replaceAll('.', ',')}',
                            visible: isVisible.value,
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () =>
                                  isVisible.value = !isVisible.value,
                              icon: Icon(
                                isVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
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
                                'R\$ ${controller.displayBalance('expense').toStringAsFixed(2).replaceAll('.', ',')}',
                            visible: isVisible.value,
                          ),
                          TotalTile(
                            icon: Icons.arrow_upward,
                            label: 'Receitas',
                            value:
                                'R\$ ${controller.displayBalance('income').toStringAsFixed(2).replaceAll('.', ',')}',
                            visible: isVisible.value,
                          ),
                        ],
                      ),
                      SizedBox(height: spaceBetween),
                    ],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
