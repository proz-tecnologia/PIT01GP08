import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../design_sys/sizes.dart';
import '../statistics_states.dart';

class Chart extends StatelessWidget {
  const Chart(this.state, {super.key});

  final SuccessStatisticsState state;

  @override
  Widget build(BuildContext context) {
    final screenMinSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

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
                    title: '',
                    badgeWidget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(state.sections[i].icon),
                        Text('${state.sections[i].percent.toInt()}%'),
                      ],
                    ),
                    badgePositionPercentageOffset: 2,
                    radius: isTouched
                        ? screenMinSize * Sizes.tenPercent
                        : screenMinSize * Sizes.sevenPercent,
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
