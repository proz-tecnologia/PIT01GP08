import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import '../data_controller.dart';
import '../data_states.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final index = ValueNotifier(0);

    return BlocBuilder<DataController, DataState>(
      builder: (context, state) => ValueListenableBuilder(
        valueListenable: index,
        builder: (_, value, __) => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: Sizes.extraLargeSpace),
                child: Icon(Icons.import_export_rounded),
              ),
              label: 'Extrato',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: Sizes.extraLargeSpace),
                child: Icon(Icons.equalizer_rounded),
              ),
              label: 'Estatística',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Mais',
            ),
          ],
          currentIndex: value,
          onTap: (newIndex) {
            if (state is! LoadingDataState) {
              controller.jumpToPage(newIndex);
              index.value = newIndex;
            }
          },
        ),
      ),
    );
  }
}
