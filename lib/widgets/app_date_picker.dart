import 'package:flutter/material.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    Key? key,
    required Color color,
  })  : _color = color,
        super(key: key);

  final Color _color;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return TextFormField(
      //TODO: format
      initialValue: date.toString(),
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today),
        labelStyle: TextStyle(color: widget._color),
        labelText: 'Vencimento',
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );

        if (pickedDate != null) {
          setState(() {
            date = pickedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
