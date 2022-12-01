import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import 'new_entry_states.dart';

class NewEntryController extends Cubit<NewEntryState> {
  late final List<String> expenseCategories;
  late final List<String> incomeCategories;

  NewEntryController() : super(LoadingNewEntryState()) {
    init();
  }

  void init() async {
    emit(LoadingNewEntryState());
    try {
      //trocar pela requisição na api
      expenseCategories = mockedExpenseCategories;
      incomeCategories = mockedIncomeCategories;

      emit(ExpenseNewEntryState());
    } catch (e) {
      emit(ErrorNewEntryState());
    }
  }

  void changeType({required bool isIncome}) {
    if (isIncome && state is ExpenseNewEntryState) {
      emit(IncomeNewEntryState());
    } else if (state is IncomeNewEntryState) {
      emit(ExpenseNewEntryState());
    }
  }

  void saveTransaction(Transaction transaction) async {
    final lastTypeState = state;
    emit(SavingNewEntryState());
    try {
      //fazer post na api

      // para testes de gerência de estado:
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      if (random.nextBool() && random.nextBool()) {
        throw Exception();
      }

      emit(SuccessNewEntryState());
    } catch (e) {
      emit(SavingErrorNewEntryState());
      emit(lastTypeState);
    }
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
  'Aluguel',
];
