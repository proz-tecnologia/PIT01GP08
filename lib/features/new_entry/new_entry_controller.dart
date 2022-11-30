import 'package:flutter_bloc/flutter_bloc.dart';

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

  void changeType(bool isIncome) {
    if (isIncome && state is ExpenseNewEntryState) {
      emit(IncomeNewEntryState());
    } else if (state is IncomeNewEntryState) {
      emit(ExpenseNewEntryState());
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
];
