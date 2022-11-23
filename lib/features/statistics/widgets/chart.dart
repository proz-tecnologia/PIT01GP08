import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../statistics_controller.dart';
import '../../../design_sys/colors.dart';

class Chart extends StatelessWidget {
  const Chart(
    this.controller, {
    Key? key,
  }) : super(key: key);

  final StatisticsController controller;

  @override
  Widget build(BuildContext context) {
    final screenMinSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Text(
          'Total:\nR\$${controller.total.toStringAsFixed(2).replaceFirst('.', ',')}',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        AnimatedBuilder(
          animation: controller.touchedIndex,
          builder: (context, child) => PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    controller.touchedIndex.value = -1;
                    return;
                  }
                  controller.touchedIndex.value =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                },
              ),
              sectionsSpace: 0,
              startDegreeOffset: 270,
              centerSpaceRadius: screenMinSize * 0.2,
              sections: List.generate(
                controller.sections.length,
                (i) {
                  final isTouched = i == controller.touchedIndex.value;
                  return PieChartSectionData(
                    color: controller.sections[i].color,
                    value: controller.sections[i].percent,
                    title: '${controller.sections[i].percent.toInt()}%',
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
