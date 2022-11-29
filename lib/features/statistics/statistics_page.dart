import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/month_changer.dart';
import 'statistics_controller.dart';
import 'statistics_states.dart';
import 'widgets/chart.dart';
import 'widgets/legend.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              MonthChanger('Dezembro'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_rounded),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<StatisticsController, StatisticsState>(
            builder: (context, currentState) {
              if (currentState is ErrorStatisticsState) {
                return const Center(
                  child: Text('Erro'),
                );
              }
              if (currentState is SuccessStatisticsState) {
                final screenOrientation = MediaQuery.of(context).orientation;
                return screenOrientation == Orientation.portrait
                    ? Column(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Center(child: Chart()),
                          ),
                          Expanded(flex: 2, child: Legend()),
                        ],
                      )
                    : Row(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Center(child: Chart()),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Legend(),
                            ),
                          ),
                        ],
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
