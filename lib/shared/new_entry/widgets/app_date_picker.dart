import 'package:financial_app/shared/new_entry/entry_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    Key? key,
    required ValueNotifier<EntryType> typeNotifier,
    required ValueNotifier<bool> checkboxNotifier,
  })  : _isChecked = checkboxNotifier,
        _typeNotifier = typeNotifier,
        super(key: key);

  final ValueNotifier<EntryType> _typeNotifier;
  final ValueNotifier<bool> _isChecked;

  @override
  State<AppDatePicker> createState() => AppDatePickerState();
}

class AppDatePickerState extends State<AppDatePicker> {
  TextEditingController dateInput = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._typeNotifier,
      builder: (context, child) {
        final color = widget._typeNotifier.value.color;
        return TextFormField(
          controller: dateInput,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              color: color,
            ),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            labelStyle: TextStyle(color: color),
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
      },
    );
  }
}
