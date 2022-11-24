import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

enum Type { expense, income }

class NewEntryChangeNotifier extends ChangeNotifier {
  Color _color = AppColors.expense;
  List<String> _categories = mockedExpenseCategories;
  String _fulfilledLabel = 'Pago';
  bool _fulfilled = true;

  Color get color => _color;
  List<String> get categories => _categories;
  String get fulfilledLabel => _fulfilledLabel;
  bool get initialFulfilled => _fulfilled;

  void changeType(Type type) {
    if (type == Type.expense) {
      _color = AppColors.expense;
      _categories = mockedExpenseCategories;
      _fulfilledLabel = 'Pago';
    } else {
      _color = AppColors.income;
      _categories = mockedIncomeCategories;
      _fulfilledLabel = 'Recebido';
    }
    notifyListeners();
  }

  void checkFulfilled() {
    _fulfilled = true;
    notifyListeners();
  }

  void uncheckFulfilled() {
    _fulfilled = false;
    notifyListeners();
  }

  void changeLabel({required bool normal}) {
    if (normal) {
      _fulfilledLabel = _color == AppColors.expense ? 'Pago' : 'Recebido';
    } else {
      if (!_fulfilledLabel.contains(' (mês atual)')) {
        _fulfilledLabel += ' (mês atual)';
      }
    }
    notifyListeners();
  }
}

final mockedExpenseCategories = <String>[
  'Alimentação',
  'Combustível',
  'Saúde',
  'Água',
  'Energia',
];

final mockedIncomeCategories = <String>[
  'Salário',
  'Presente',
];
