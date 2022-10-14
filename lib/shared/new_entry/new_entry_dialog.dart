import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/app_currency_field.dart';
import 'widgets/app_date_picker.dart';
import 'widgets/app_dropdown_button_form_field.dart';
import 'widgets/app_toggle_buttons.dart';

Future<void> newEntryDialog(BuildContext context, String type) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return NewEntryDialog();
      });
}

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

class NewEntryDialog extends StatefulWidget {
  NewEntryDialog({Key? key}) : super(key: key);

  final List<bool> _selectType = <bool>[true, false];
  final List<bool> _select = <bool>[true, false, false];

  @override
  State<NewEntryDialog> createState() => _NewEntryDialogState();
}

class _NewEntryDialogState extends State<NewEntryDialog> {
  List<String> _categories = expenseCategories;
  Color _color = AppColors.expense;

  @override
  Widget build(BuildContext context) {
    var topBar = ToggleButtons(
      constraints: const BoxConstraints(minWidth: 146),
      selectedColor: _color,
      fillColor: Theme.of(context).backgroundColor,
      renderBorder: false,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < widget._selectType.length; i++) {
            widget._selectType[i] = i == index;
            _categories = index == 0 ? expenseCategories : incomeCategories;
            _color = index == 0 ? AppColors.expense : AppColors.income;
          }
        });
      },
      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      isSelected: widget._selectType,
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Despesa'),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Receita'),
        ),
      ],
    );

    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: topBar,
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CurrencyFormField(color: _color),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(color: _color),
                labelStyle: TextStyle(color: _color.withOpacity(0.6)),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: _color)),
                labelText: 'Descrição',
              ),
            ),
            const SizedBox(height: 8),
            AppDropdownButtonFormField(categories: _categories, color: _color),
            const SizedBox(height: 16),
            AppToggleButtons(select: widget._select, color: _color),
            const SizedBox(height: 8),
            AppDatePicker(color: _color),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: _color),
          onPressed: () {
            //TODO: submit
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
