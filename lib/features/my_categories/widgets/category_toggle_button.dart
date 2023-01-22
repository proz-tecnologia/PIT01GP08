import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';
import '../../../design_sys/sizes.dart';
import '../../../shared/models/category.dart';

class CategoryToogleButton extends StatefulWidget {
  const CategoryToogleButton({
    super.key,
    required this.type,
  });

  final ValueNotifier<Type> type;

  @override
  State<CategoryToogleButton> createState() => _CategoryToogleButtonState();
}

class _CategoryToogleButtonState extends State<CategoryToogleButton> {
  @override
  Widget build(BuildContext context) {
    final select =
        widget.type.value == Type.income ? [true, false] : [false, true];
    return ToggleButtons(
      selectedColor: Theme.of(context).colorScheme.background,
      fillColor: widget.type.value == Type.expense
          ? AppColors.expense
          : AppColors.income,
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.smallSpace)),
      isSelected: select,
      onPressed: (index) {
        setState(() {
          widget.type.value = index == 0 ? Type.income : Type.expense;
        });
      },
      children: const [
        Padding(
          padding: EdgeInsets.all(Sizes.smallSpace),
          child: Text('Receitas'),
        ),
        Padding(
          padding: EdgeInsets.all(Sizes.smallSpace),
          child: Text('Despesas'),
        ),
      ],
    );
  }
}
