import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormField extends StatelessWidget {
  const CurrencyFormField({
    Key? key,
    required Color color,
    this.initialValue,
  })  : _color = color,
        super(key: key);

  final Color _color;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      showCursor: false,
      textInputAction: TextInputAction.next,
      initialValue: initialValue,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: _color),
        labelStyle: TextStyle(color: _color.withOpacity(0.6)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: _color)),
        labelText: 'Valor',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        int intValue = int.parse(value.replaceAll(RegExp('[R\$,]'), ''));
        if (intValue == 0) {
          return 'O valor não pode ser zero.';
        }
        return null;
      },
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
