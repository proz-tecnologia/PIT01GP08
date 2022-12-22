import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import '../statistics_controller.dart';
import '../statistics_states.dart';

class Legend extends StatelessWidget {
  const Legend(this.state, {super.key});

    final SuccessStatisticsState state;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: state.sections.length,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: state.touchedIndex,
        builder: (context, child) {
          return ListTile(
            onTap: () =>
                state.touchedIndex.value = state.touchedIndex.value == index ? -1 : index,
            leading: SizedBox(
              width: width * Sizes.tenPercent,
              child: Center(
                child: CircleAvatar(
                    radius: state.touchedIndex.value == index ? 12 : 8,
                    backgroundColor: state.sections[index].color),
              ),
            ),
            title: Text(state.sections[index].description),
            trailing: Text(
                'R\$ ${state.sections[index].value.toStringAsFixed(2).replaceFirst('.', ',')}'),
          );
        },
      ),
    );
  }
}
