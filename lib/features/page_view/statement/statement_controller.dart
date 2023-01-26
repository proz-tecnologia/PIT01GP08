import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../shared/models/category.dart';
import '../../../shared/models/transaction.dart';
import '../../../shared/utils/select_by_date.dart';
import 'statement_states.dart';

class StatementController extends Cubit<StatementState> {
  StatementController(this.transactionList)
      : super(BothStatementState(transactionList));

  final List<Transaction> transactionList;
  DateTime currentMonth = DateTime.now();

  double _previousBalance = 0;
  double _income = 0;
  double _expense = 0;
  String get previousBalance =>
      'R\$ ${_previousBalance.toStringAsFixed(2).replaceAll('.', ',')}';
  String get income => 'R\$ ${_income.toStringAsFixed(2).replaceAll('.', ',')}';
  String get expense =>
      'R\$ ${_expense.toStringAsFixed(2).replaceAll('.', ',')}';

  double _partialBalance = 0;
  double _totalBalance = 0;
  String get partialBalance =>
      'R\$ ${_partialBalance.toStringAsFixed(2).replaceAll('.', ',')}';
  String get totalBalance =>
      'R\$ ${_totalBalance.toStringAsFixed(2).replaceAll('.', ',')}';

  String get displayMonth =>
      DateFormat('MMMM', 'pt_Br').format(currentMonth).toUpperCase();

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

  void fulfillOnScreen(Transaction transaction) {
    final stateCopy = state;
    toggleState(false);
    transaction.fulfill();
    emit(stateCopy);
  }

  void deleteFromScreen(Transaction transaction) {
    final stateCopy = state;
    toggleState(false);
    stateCopy.list.removeWhere((e) => e.id == transaction.id);
    emit(stateCopy);
  }

  void displayBalance() {
    _previousBalance = 0;
    _income = 0;
    _expense = 0;

    _partialBalance = 0;
    _totalBalance = 0;

    final dayOneOfMonth = DateTime(currentMonth.year, currentMonth.month);
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);

    for (var transaction in transactionList) {
      if (transaction.date.isBefore(dayOneOfMonth)) {
        if (transaction.type == Type.income) {
          _previousBalance += transaction.value;
        } else {
          _previousBalance -= transaction.value;
        }
      } else if (transaction.date.isBefore(nextMonth)) {
        if (transaction.type == Type.income) {
          _income += transaction.value;
        } else {
          _expense -= transaction.value;
        }
      }
    }

    _partialBalance = _income + _expense;
    _totalBalance = _previousBalance + _partialBalance;
  }
}
