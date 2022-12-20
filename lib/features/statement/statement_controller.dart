import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import 'statement_states.dart';

class StatementController extends Cubit<StatementState> {
  StatementController(this.transactionList)
      : super(BothStatementState(transactionList));

  final List<Transaction> transactionList;
  DateTime currentMonth = DateTime.now();

  void toggleState(bool isIncome) async {
    if (state is BothStatementState) {
      if (isIncome) {
        emit(ExpenseStatementState(transactionList));
      } else {
        emit(IncomeStatementState(transactionList));
      }
    } else if ((state is ExpenseStatementState && isIncome) ||
        (state is IncomeStatementState && !isIncome)) {
      emit(BothStatementState(transactionList));
    }
    showTransactions(currentMonth);
  }

  void showTransactions(DateTime displayMonth) {
    currentMonth = displayMonth;

    final List<Transaction> monthTransactionList;
    final startMonth = displayMonth.month;
    final startYear = displayMonth.year;

    final endMonth = startMonth == 1 ? 12 : startMonth - 1;
    final endYear = startMonth == 1 ? startYear - 1 : startYear;

    int startIndex = transactionList.indexWhere((element) =>
        element.date.year == startYear && element.date.month == startMonth);
    int endIndex = transactionList.indexWhere((element) =>
        element.date.year == endYear && element.date.month == endMonth);
    if (startIndex == -1) {
      startIndex = transactionList.length;
      endIndex = transactionList.length;
    } else if (endIndex == -1) {
      endIndex = transactionList.length;
    }

    monthTransactionList =
        transactionList.getRange(startIndex, endIndex).toList();

    emit(state.copyWith(monthTransactionList));
  }
}
