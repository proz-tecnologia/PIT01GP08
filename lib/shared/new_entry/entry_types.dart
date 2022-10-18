import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/animation.dart';

class EntryType {
  EntryType._({
    required color,
    required categories,
    required fulfilledLabel,
  })  : _color = color,
        _categories = categories,
        _fulfilledLabel = fulfilledLabel;

  final Color _color;
  final List<String> _categories;
  final String _fulfilledLabel;

  Color get color => _color;
  List<String> get categories => _categories;
  String get fulfilledLabel => _fulfilledLabel;
}

class EntryTypes {
  static final EntryType expense = EntryType._(
      color: AppColors.expense,
      categories: <String>[
        'Alimentação',
        'Combustível',
        'Saúde',
        'Água',
        'Energia',
      ],
      fulfilledLabel: 'Pago');

  static final EntryType income = EntryType._(
      color: AppColors.income,
      categories: <String>[
        'Salário',
        'Presente',
      ],
      fulfilledLabel: 'Recebido');
}
