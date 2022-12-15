import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MonthChanger extends StatefulWidget {
  const MonthChanger(
    this.changeMonthAction, {
    super.key,
  });

  final Function(DateTime month) changeMonthAction;

  @override
  State<MonthChanger> createState() => _MonthChangerState();
}

class _MonthChangerState extends State<MonthChanger> {
  final currentMonth = ValueNotifier(DateTime.now());
  String displayMonth = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentMonth,
        builder: (_, value, __) {
          displayMonth = toBeginningOfSentenceCase(
                  DateFormat('MMMM', 'pt_Br').format(value)) ??
              '';
          return Row(
            children: [
              IconButton(
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    final previousMonth = value.month == 1 // IF January
                        ? DateTime(value.year - 1, 12) // THEN last December
                        : DateTime(value.year, value.month - 1);
                    widget.changeMonthAction(previousMonth);
                    currentMonth.value = previousMonth;
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              InkWell(
                onTap: () {},
                child: Text(
                  displayMonth,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              IconButton(
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    final nextMonth = value.month == 12 // IF December
                        ? DateTime(value.year + 1, 1) // THEN next year, January
                        : DateTime(value.year, value.month + 1);
                    widget.changeMonthAction(nextMonth);
                    currentMonth.value = nextMonth;
                  },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ],
          );
        });
  }
}
