import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField(
    this.textController, {
    super.key,
    required this.label,
  });

  final TextEditingController textController;
  final String label;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  @override
  void initState() {
    super.initState();
    if (widget.textController.text == '') {
      widget.textController.text =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.textController,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              color: state.color,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: state.color)),
            labelStyle: TextStyle(color: state.color),
            labelText: widget.label,
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
              widget.textController.text =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
        );
      },
    );
  }
}
