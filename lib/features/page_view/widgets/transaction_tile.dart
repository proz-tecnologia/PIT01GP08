import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';
import '../../../design_sys/sizes.dart';
import '../../../shared/models/category.dart';
import '../../../shared/models/transaction.dart';
import '../../../shared/utils/currency_format.dart';

class TransactionTile extends StatefulWidget {
  const TransactionTile(
    this.transaction, {
    super.key,
    this.category,
    required this.trailingCondition,
    required this.trailingIcon,
    this.actions,
  });

  final Transaction transaction;
  final Category? category;
  final Icon trailingIcon;
  final bool trailingCondition;
  final List<Widget>? actions;

  factory TransactionTile.alert(
    Transaction transaction, {
    Category? category,
  }) {
    return TransactionTile(
      transaction,
      category: category,
      trailingCondition: transaction.date.isBefore(DateTime.now()),
      trailingIcon: const Icon(
        Icons.priority_high_rounded,
        color: AppColors.expense,
      ),
    );
  }

  factory TransactionTile.check(
    Transaction transaction, {
    required Category category,
    List<Widget>? actions,
  }) {
    return TransactionTile(
      transaction,
      category: category,
      trailingCondition: transaction.fulfilled,
      trailingIcon: const Icon(
        Icons.check_circle_rounded,
        color: AppColors.primary,
        size: Sizes.smallIconSize,
      ),
      actions: actions,
    );
  }

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  final isExpanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Icon trailingIconCopy = widget.trailingIcon;
    if (widget.trailingIcon.color == AppColors.primary &&
        Theme.of(context).brightness == Brightness.dark) {
      trailingIconCopy = Icon(
        widget.trailingIcon.icon,
        color: AppColors.primaryOnDark,
        size: widget.trailingIcon.size,
        semanticLabel: widget.trailingIcon.semanticLabel,
        textDirection: widget.trailingIcon.textDirection,
        shadows: widget.trailingIcon.shadows,
      );
    }

    return ExpansionTile(
      initiallyExpanded: isExpanded.value,
      onExpansionChanged: (value) {
        setState(() {
          isExpanded.value = value;
        });
      },
      leading: widget.category != null
          ? AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: isExpanded.value ? 1 : 0,
              child: Icon(
                widget.category?.icon,
                color: widget.category?.color,
              ),
            )
          : null,
      title: widget.category != null
          ? AnimatedSlide(
              offset: isExpanded.value ? Offset.zero : const Offset(-0.25, 0),
              duration: const Duration(milliseconds: 300),
              child: Text(
                widget.transaction.value.toBrReal,
                style: TextStyle(
                  color: widget.transaction.type == Type.expense
                      ? AppColors.expense
                      : AppColors.income,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Text(
              widget.transaction.value.toBrReal,
              style: TextStyle(
                color: widget.transaction.type == Type.expense
                    ? AppColors.expense
                    : AppColors.income,
                fontWeight: FontWeight.bold,
              ),
            ),
      subtitle: widget.category != null
          ? AnimatedSlide(
              offset: isExpanded.value ? Offset.zero : const Offset(-0.25, 0),
              duration: const Duration(milliseconds: 300),
              child: Text(
                '${widget.transaction.description} ${isExpanded.value ? '(${widget.category!.name})' : ''}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            )
          : Text(
              widget.transaction.description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.transaction.date.day}/${widget.transaction.date.month}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
          ),
          widget.trailingCondition
              ? Padding(
                  padding: const EdgeInsets.only(left: Sizes.smallSpace),
                  child: trailingIconCopy,
                )
              : const SizedBox.shrink(),
        ],
      ),
      children: [
        Row(children: widget.actions ?? []),
      ],
    );
  }
}
