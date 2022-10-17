import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    Key? key,
    required Color color,
    required checkboxNotifier,
  })  : _isChecked = checkboxNotifier,
        _color = color,
        super(key: key);

  final Color _color;
  final ValueNotifier<bool> _isChecked;

  @override
  State<AppDatePicker> createState() => AppDatePickerState();
}

class AppDatePickerState extends State<AppDatePicker> {
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
            if (pickedDate.isAfter(DateTime.now())) {
              widget._isChecked.value = false;
            } else {
              widget._isChecked.value = true;
            }
          });
        }
      },
    );
  }
}
