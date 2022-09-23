import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_dropdown_button_form_field.dart';
import '../widgets/app_toggle_buttons.dart';

Future<void> newEntryDialog(BuildContext context, String type) {
  final List<bool> select = <bool>[true, false, false];
  final List<String> expenseCategories = <String>[
    'Alimentação',
    'Combustível',
    'Saúde',
    'Água',
    'Energia',
  ];
  final List<String> incomeCategories = <String>[
    'Salário',
    'Presente',
  ];
  final categories = type == 'income' ? incomeCategories : expenseCategories;
  final color = type == 'income' ? AppColors.income : AppColors.expense;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEntryDialog(
          categories: categories,
          select: select,
          color: color,
        );
      });
}

class NewEntryDialog extends StatelessWidget {
  const NewEntryDialog({
    Key? key,
    required List<String> categories,
    required Color color,
    required List<bool> select,
  })  : _categories = categories,
        _color = color,
        _select = select,
        super(key: key);

  final List<String> _categories;
  final Color _color;
  final List<bool> _select;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova despesa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Valor',
              prefixText: 'R\$ ',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Descrição',
            ),
          ),
          AppDropdownButtonFormField(categories: _categories),
          AppToggleButtons(select: _select, color: _color),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            //TODO: submit
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
