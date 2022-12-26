import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import '../page_view/shared/models/category.dart';

abstract class NewEntryState {}

abstract class NewEntryTypeState {
  final List<Category> categories;
  final Color color;
  final String initialFulfilledLabel;

  NewEntryTypeState(
    this.categories,
    this.color,
    this.initialFulfilledLabel,
  );
}

class IncomeNewEntryState implements NewEntryTypeState {
  @override
  List<Category> categories;

  @override
  Color color = AppColors.income;

  @override
  String initialFulfilledLabel = 'Recebido';

  IncomeNewEntryState(this.categories);
}

class ExpenseNewEntryState implements NewEntryTypeState {
  @override
  List<Category> categories;

  @override
  Color color = AppColors.expense;

  @override
  String initialFulfilledLabel = 'Pago';

  ExpenseNewEntryState(this.categories);
}

class InitialNewEntryState implements NewEntryState {}

class SavingNewEntryState implements NewEntryState {}

class SuccessNewEntryState implements NewEntryState {}

class ErrorNewEntryState implements NewEntryState {}
