import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  TextEditingController dateInput = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dateInput,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.calendar_today_rounded,
          color: widget._color,
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: widget._color)),
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
            dateInput.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          });
        }
      },
    );
  }
}
