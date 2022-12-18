import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';
import '../../shared/models/category.dart';

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

class IncomeNewEntryState implements NewEntryState, NewEntryTypeState {
  @override
  List<Category> categories;

  @override
  Color color = AppColors.income;

  @override
  String initialFulfilledLabel = 'Recebido';

  IncomeNewEntryState(this.categories);
}

class ExpenseNewEntryState implements NewEntryState, NewEntryTypeState {
  @override
  List<Category> categories;

  @override
  Color color = AppColors.expense;

  @override
  String initialFulfilledLabel = 'Pago';

  ExpenseNewEntryState(this.categories);
}

class SavingNewEntryState implements NewEntryState {}

class SuccessNewEntryState implements NewEntryState {}

class ErrorNewEntryState implements NewEntryState {}
