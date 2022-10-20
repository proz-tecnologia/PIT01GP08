import 'package:financial_app/shared/new_entry/entry_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyFormField extends StatelessWidget {
  const CurrencyFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => TextFormField(
            autofocus: true,
            showCursor: false,
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: notifier.color),
              labelStyle: TextStyle(color: notifier.color.withOpacity(0.6)),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: notifier.color)),
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
          ),
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
