import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import '../../shared/transaction_repository.dart';
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
      //trocar pela requisição na api - sprint 3
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
      final success =
          await TransactionFirebaseRepository().createTransaction(transaction);
      if (success) {
        emit(SuccessNewEntryState());
        return;
      }
      throw Exception();
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
