import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import 'entry_types.dart';
import 'components/widgets.dart';

Future<void> newEntryDialog(BuildContext context, String type) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEntryDialog();
      });
}

class NewEntryDialog extends StatefulWidget {
  NewEntryDialog({Key? key}) : super(key: key);

  final ValueNotifier<EntryType> _typeNotifier =
      ValueNotifier<EntryType>(EntryTypes.expense);
  final ValueNotifier<String> _fulfilledCheckboxLabel =
      ValueNotifier<String>('Pago');
  final ValueNotifier<bool> _fulfilledChecked = ValueNotifier<bool>(true);

  @override
  State<NewEntryDialog> createState() => _NewEntryDialogState();
}

class _NewEntryDialogState extends State<NewEntryDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title:
          NewEntryTopBar(widget._typeNotifier, widget._fulfilledCheckboxLabel),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CurrencyFormField(widget._typeNotifier),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: widget._typeNotifier,
              builder: (context, child) {
                final color = widget._typeNotifier.value.color;
                return TextFormField(
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: color),
                    labelStyle: TextStyle(color: color.withOpacity(0.6)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: color)),
                    labelText: 'Descrição',
                  ),
                  cursorColor: AppColors.lightGrey,
                );
              },
            ),
            const SizedBox(height: 8),
            AppDropdownButtonFormField(widget._typeNotifier),
            const SizedBox(height: 16),
            AppToggleButtons(
              typeNotifier: widget._typeNotifier,
              labelNotifier: widget._fulfilledCheckboxLabel,
            ),
            const SizedBox(height: 8),
            AppDatePicker(
              typeNotifier: widget._typeNotifier,
              checkboxNotifier: widget._fulfilledChecked,
            ),
            const SizedBox(height: 8),
            AppFulfilledCheck(
              typeNotifier: widget._typeNotifier,
              checkboxNotifier: widget._fulfilledChecked,
              labelNotifier: widget._fulfilledCheckboxLabel,
            )
          ],
        ),
      ),
      actions: [
        AnimatedBuilder(
          animation: widget._typeNotifier,
          builder: (context, child) => ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: widget._typeNotifier.value.color),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Entrada salva com sucesso.')),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}
