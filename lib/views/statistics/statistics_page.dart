import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../controllers/statistics_controller.dart';
import '../../design_sys/colors.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final controller = StatisticsController();
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final screenMinSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Center(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          sectionsSpace: 0,
          centerSpaceRadius: screenMinSize * 0.2,
          sections: List.generate(
            controller.sections.length,
            (i) {
              final isTouched = i == touchedIndex;
              return PieChartSectionData(
                color: controller.sections[i].color,
                value: controller.sections[i].percent,
                title: '${controller.sections[i].percent.toInt()}%',
                radius: isTouched ? screenMinSize * 0.23 : screenMinSize * 0.2,
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
