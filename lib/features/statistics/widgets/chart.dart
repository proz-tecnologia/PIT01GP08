import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../statistics_controller.dart';
import '../statistics_states.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenMinSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    final state = context.read<StatisticsController>().state as SuccessStatisticsState;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Text(
          'Total:\nR\$${state.total.toStringAsFixed(2).replaceFirst('.', ',')}',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        AnimatedBuilder(
          animation: state.touchedIndex,
          builder: (context, child) => PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    state.touchedIndex.value = -1;
                    return;
                  }
                  state.touchedIndex.value =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                },
              ),
              sectionsSpace: 0,
              startDegreeOffset: 270,
              centerSpaceRadius: screenMinSize * 0.2,
              sections: List.generate(
                state.sections.length,
                (i) {
                  final isTouched = i == state.touchedIndex.value;
                  return PieChartSectionData(
                    color: state.sections[i].color,
                    value: state.sections[i].percent,
                    title: '${state.sections[i].percent.toInt()}%',
                    radius:
                        isTouched ? screenMinSize * 0.23 : screenMinSize * 0.2,
                    titleStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
