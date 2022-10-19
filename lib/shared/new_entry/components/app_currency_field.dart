import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../entry_types.dart';

class CurrencyFormField extends StatelessWidget {
  const CurrencyFormField(
    ValueNotifier<EntryType> typeNotifier,{
    Key? key,
  })  : _typeNotifier = typeNotifier,
        super(key: key);

  final ValueNotifier<EntryType> _typeNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typeNotifier,
      builder: (context, child) {
        final color = _typeNotifier.value.color;
        return TextFormField(
          autofocus: true,
          showCursor: false,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: color),
            labelStyle: TextStyle(color: color.withOpacity(0.6)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
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
