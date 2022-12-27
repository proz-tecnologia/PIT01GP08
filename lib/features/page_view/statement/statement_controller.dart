import 'package:financial_app/shared/utils/select_by_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/transaction.dart';
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

    final monthTransactionList = transactionList.getMonthRange(displayMonth);

    emit(state.copyWith(monthTransactionList));
  }
}
