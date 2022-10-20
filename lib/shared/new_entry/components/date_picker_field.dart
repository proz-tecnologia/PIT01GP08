import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../change_notifier.dart';

class AppDatePickerField extends StatefulWidget {
  const AppDatePickerField({Key? key}) : super(key: key);

  @override
  State<AppDatePickerField> createState() => AppDatePickerFieldState();
}

class AppDatePickerFieldState extends State<AppDatePickerField> {
  TextEditingController dateInput = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => TextFormField(
        controller: dateInput,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: notifier.color,
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: notifier.color)),
          labelStyle: TextStyle(color: notifier.color),
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
                notifier.uncheckFulfilled();
              } else {
                notifier.checkFulfilled();
              }
            });
          }
        },
      ),
    );
  }
}
