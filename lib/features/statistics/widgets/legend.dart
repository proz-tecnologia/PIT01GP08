import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../statistics_controller.dart';

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = context.read<StatisticsController>();
    return ListView.builder(
      itemCount: controller.sections.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: controller.touchedIndex,
        builder: (context, child) {
          return ListTile(
            onTap: () => controller.touchedIndex.value =
                controller.touchedIndex.value == index ? -1 : index,
            leading: SizedBox(
              width: width * 0.1,
              child: Center(
                child: CircleAvatar(
                    radius: controller.touchedIndex.value == index ? 12 : 8,
                    backgroundColor: controller.sections[index].color),
              ),
            ),
            title: Text(controller.sections[index].description),
            trailing: Text(
                'R\$${controller.sections[index].value.toStringAsFixed(2).replaceFirst('.', ',')}'),
          );
        },
      ),
    );
  }
}
