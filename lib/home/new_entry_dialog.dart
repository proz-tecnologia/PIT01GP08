import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/app_date_picker.dart';
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
  final title = type == 'income' ? 'Nova receita' : 'Nova despesa';

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEntryDialog(
          categories: categories,
          color: color,
          select: select,
          title: title,
        );
      });
}

class NewEntryDialog extends StatelessWidget {
  const NewEntryDialog({
    Key? key,
    required List<String> categories,
    required Color color,
    required List<bool> select,
    required String title,
  })  : _categories = categories,
        _color = color,
        _select = select,
        _title = title,
        super(key: key);

  final List<String> _categories;
  final Color _color;
  final List<bool> _select;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      titleTextStyle:
          TextStyle(color: _color, fontWeight: FontWeight.w500, fontSize: 16),
      title: Text(_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: _color.withOpacity(0.6)),
              labelText: 'Valor',
              prefixText: 'R\$ ',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: _color.withOpacity(0.6)),
              labelText: 'Descrição',
            ),
          ),
          AppDropdownButtonFormField(categories: _categories),
          AppToggleButtons(select: _select, color: _color),
          AppDatePicker(color: _color),
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
