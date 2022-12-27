import 'package:financial_app/shared/views/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/views/error_view.dart';
import '../../../shared/views/loading_view.dart';
import '../widgets/month_changer.dart';
import '../data_controller.dart';
import '../data_states.dart';
import 'statistics_controller.dart';
import 'statistics_states.dart';
import 'widgets/chart.dart';
import 'widgets/legend.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataState = context.read<DataController>().state as SuccessDataState;
    final controller = StatisticsController(
      dataState.transactionList,
      dataState.categoryList,
    );
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: MonthChanger((month) => controller.getSections(month)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_rounded),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<StatisticsController, StatisticsState>(
            bloc: controller,
            builder: (context, state) {
              if (state is ErrorStatisticsState) {
                return ErrorView(
                  icon: Icons.sync_problem_rounded,
                  text: state.message,
                );
              }
              if (state is SuccessStatisticsState) {
                if (state.sections.isEmpty) {
                  return const EmptyView('Ainda não há despesas nesse mês');
                }
                final screenOrientation = MediaQuery.of(context).orientation;
                return screenOrientation == Orientation.portrait
                    ? Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(child: Chart(state)),
                          ),
                          Expanded(flex: 2, child: Legend(state)),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(child: Chart(state)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Legend(state),
                            ),
                          ),
                        ],
                      );
              }
              return const LoadingView();
            },
          ),
        ),
      ],
    );
  }
}
