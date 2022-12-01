import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

abstract class NewEntryState {}

abstract class NewEntryTypeState {
  late final Color color;
  late final String initialFulfilledLabel;
}

class IncomeNewEntryState implements NewEntryState, NewEntryTypeState {
  @override
  Color color = AppColors.income;

  @override
  String initialFulfilledLabel = 'Recebido';
}

class ExpenseNewEntryState implements NewEntryState, NewEntryTypeState {
  @override
  Color color = AppColors.expense;

  @override
  String initialFulfilledLabel = 'Pago';
}

class LoadingNewEntryState implements NewEntryState {}

class SavingNewEntryState implements NewEntryState {}

class SuccessNewEntryState implements NewEntryState {}

class ErrorNewEntryState implements NewEntryState {}

class SavingErrorNewEntryState implements NewEntryState {}
