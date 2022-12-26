import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatelessWidget {
  const MonthPicker({
    super.key,
    required this.changeMonthAction,
    required this.currentMonth,
  });

  final Function(DateTime month) changeMonthAction;
  final DateTime currentMonth;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${currentMonth.year}',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.5,
          ),
          itemCount: 12,
          itemBuilder: (_, index) => InkWell(
            onTap: () {
              changeMonthAction(DateTime(currentMonth.year, index + 1));
              Navigator.of(context).pop();
            },
            child: Center(
              child: Text(DateFormat('MMM', 'pt_Br')
                  .format(DateTime(currentMonth.year, index + 1))
                  .toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
