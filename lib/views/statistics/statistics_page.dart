import 'package:flutter/material.dart';

import '../../controllers/statistics_controller.dart';
import 'statistics_states.dart';
import 'widgets/chart.dart';
import 'widgets/legend.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = StatisticsController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StatisticsState>(
      valueListenable: controller.state,
      builder: (context, currentState, child) {
        if (currentState is ErrorStatisticsState) {
          return const Center(
            child: Text('Erro'),
          );
        }
        if (currentState is SuccessStatisticsState) {
          final screenOrientation = MediaQuery.of(context).orientation;
          return screenOrientation == Orientation.portrait
              ? Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Chart(controller),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Legend(controller),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Chart(controller),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Legend(controller),
                      ),
                    ),
                  ],
                );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
