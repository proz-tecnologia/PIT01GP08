import 'package:flutter/material.dart';

import '../../../../design_sys/colors.dart';

class TopBarToggleButton extends StatelessWidget {
  const TopBarToggleButton(
    this.text, {
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  factory TopBarToggleButton.expense({
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return TopBarToggleButton(
      'DESPESA',
      color: AppColors.expense,
      isSelected: isSelected,
      onPressed: onPressed,
    );
  }

  factory TopBarToggleButton.income({
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return TopBarToggleButton(
      'RECEITA',
      color: AppColors.income,
      isSelected: isSelected,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor:
                  isSelected ? color : Theme.of(context).secondaryHeaderColor,
            ),
            child: Text(text),
          ),
        ),
        isSelected
            ? Container(
                color: color,
                height: 2,
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
