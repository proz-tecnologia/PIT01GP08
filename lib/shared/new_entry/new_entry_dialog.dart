import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../design_sys/colors.dart';
import 'components/widgets.dart';
import 'entry_change_notifier.dart';

Future<void> newEntryDialog(BuildContext context, String type) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => NewEntryChangeNotifier(),
          child: const NewEntryDialog(),
        );
      });
}

class NewEntryDialog extends StatefulWidget {
  const NewEntryDialog({Key? key}) : super(key: key);

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
          NewEntryTopBar(),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CurrencyFormField(),
            const SizedBox(height: 8),
            Consumer<NewEntryChangeNotifier>(
              builder: (context, notifier, child) => TextFormField(
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: notifier.color),
                  labelStyle: TextStyle(color: notifier.color.withOpacity(0.6)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: notifier.color)),
                  labelText: 'Descrição',
                ),
                cursorColor: AppColors.lightGrey,
              ),
            ),
            const SizedBox(height: 8),
            const AppDropdownButtonFormField(),
            const SizedBox(height: 16),
            const AppToggleButtons(),
            const SizedBox(height: 8),
            const AppDatePicker(),
            const SizedBox(height: 8),
            const AppFulfilledCheck(),
          ],
        ),
      ),
      actions: [
        Consumer<NewEntryChangeNotifier>(
          builder: (context, notifier, child) => ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: notifier.color),
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
