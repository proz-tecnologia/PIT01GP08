import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    Key? key,
    required Color color,
    required this.textController,
  })  : _color = color,
        super(key: key);

  final Color _color;
  final TextEditingController textController;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  @override
  void initState() {
    super.initState();
    widget.textController.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
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
          widget.textController.text =
              DateFormat('dd/MM/yyyy').format(pickedDate);
        }
      },
    );
  }
}
