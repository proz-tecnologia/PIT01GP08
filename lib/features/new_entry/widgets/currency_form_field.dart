import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormField extends StatelessWidget {
  const CurrencyFormField({
    Key? key,
    required this.color,
    required this.textController,
  }) : super(key: key);

  final Color color;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: false,
      textInputAction: TextInputAction.next,
      initialValue: textController.text,
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
        _CurrencyInputFormatter(),
      ],
      validator: (value) {
        textController.text = value
                ?.replaceAll(RegExp('[R\$]'), '')
                .replaceAll('.', '')
                .replaceAll(',', '.') ??
            '';
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        int intValue = int.parse(value.replaceAll(RegExp('[R\$.,]'), ''));
        if (intValue == 0) {
          return 'O valor não pode ser zero.';
        }
        return null;
      },
    );
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
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
