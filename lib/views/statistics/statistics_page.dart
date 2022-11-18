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
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  'Total:\nR\$${controller.total.toStringAsFixed(2).replaceFirst('.', ',')}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                PieChart(
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
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sectionsSpace: 0,
                    startDegreeOffset: 270,
                    centerSpaceRadius: screenMinSize * 0.2,
                    sections: List.generate(
                      controller.sections.length,
                      (i) {
                        final isTouched = i == touchedIndex;
                        return PieChartSectionData(
                          color: controller.sections[i].color,
                          value: controller.sections[i].percent,
                          title: '${controller.sections[i].percent.toInt()}%',
                          radius: isTouched
                              ? screenMinSize * 0.23
                              : screenMinSize * 0.2,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: ListView.builder(
              itemCount: controller.sections.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => setState(() {
                  touchedIndex = touchedIndex == index ? -1 : index;
                }),
                leading: SizedBox(
                  width: screenMinSize * 0.1,
                  child: Center(
                    child: CircleAvatar(
                        radius: touchedIndex == index ? 12 : 8,
                        backgroundColor: controller.sections[index].color),
                  ),
                ),
                title: Text(controller.sections[index].description),
                trailing: Text(
                    'R\$${controller.sections[index].value.toStringAsFixed(2).replaceFirst('.', ',')}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
