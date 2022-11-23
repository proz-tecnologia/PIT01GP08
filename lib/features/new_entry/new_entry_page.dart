import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import 'components/components.dart';

class NewEntryPage extends StatefulWidget {
  NewEntryPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  List<String> _categories = expenseCategories;
  Color _color = AppColors.expense;
  String _fulfilledLabel = 'Pago';
  List<bool> _select = [true, false];
  bool check = true;

  void _changeType(int index) {
    setState(() {
      if (index == 0) {
        _categories = expenseCategories;
        _color = AppColors.expense;
        _fulfilledLabel = 'Recebido';
        _select = [true, false];
      } else {
        _categories = incomeCategories;
        _color = AppColors.income;
        _fulfilledLabel = 'Recebido';
        _select = [false, true];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                NewEntryTopBarItem(
                  'DESPESA',
                  color: AppColors.expense,
                  selected: _select[0],
                  onPressed: () => _changeType(0),
                ),
                NewEntryTopBarItem(
                  'RECEITA',
                  color: AppColors.income,
                  selected: _select[1],
                  onPressed: () => _changeType(1),
                ),
              ],
            ),
            Form(
              key: widget._formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    CurrencyFormField(color: _color),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: _color),
                        labelStyle: TextStyle(color: _color.withOpacity(0.6)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: _color)),
                        labelText: 'Descrição',
                      ),
                      cursorColor: AppColors.lightGrey,
                    ),
                    const SizedBox(height: 8),
                    AppDropdownButtonField(
                      color: _color,
                      categories: _categories,
                    ),
                    const SizedBox(height: 16),
                    AppToggleButtons(color: _color),
                    const SizedBox(height: 8),
                    AppDatePickerField(color: _color),
                    const SizedBox(height: 8),
                    AppFulfilledCheck(
                      color: _color,
                      fulfilledLabel: _fulfilledLabel,
                      initialFulfilled: check,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('OK'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('CANCELAR'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

const expenseCategories = ['e1', 'e2', 'e3'];
const incomeCategories = ['i1', 'i2', 'i3'];
