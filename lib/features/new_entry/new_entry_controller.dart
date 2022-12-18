import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import '../../shared/transaction_repository.dart';
import '../module/data_states.dart';
import 'new_entry_states.dart';

class NewEntryController extends Cubit<NewEntryState> {
  final SuccessDataState dataState;

  NewEntryController(this.dataState)
      : super(ExpenseNewEntryState(
          dataState.categoryList
              .where((category) => category.type == Type.expense)
              .toList(),
        ));

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
      emit(ErrorNewEntryState());
      emit(lastTypeState);
    }
  }
}

class NewEntryTypeController extends Cubit<NewEntryTypeState> {
  final SuccessDataState dataState;

  NewEntryTypeController(this.dataState)
      : super(ExpenseNewEntryState(
          dataState.categoryList
              .where((category) => category.type == Type.expense)
              .toList(),
        ));

  void changeType({required bool isIncome}) {
    if (isIncome && state is ExpenseNewEntryState) {
      emit(
        IncomeNewEntryState(
          dataState.categoryList
              .where((category) => category.type == Type.income)
              .toList(),
        ),
      );
    } else if (state is IncomeNewEntryState) {
      emit(
        ExpenseNewEntryState(
          dataState.categoryList
              .where((category) => category.type == Type.expense)
              .toList(),
        ),
      );
    }
  }
}
