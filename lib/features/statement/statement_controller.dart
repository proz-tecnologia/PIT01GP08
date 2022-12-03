import 'package:financial_app/shared/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import 'statement_states.dart';

class StatementController extends Cubit<StatementState> {
  StatementController() : super(LoadingStatementState()) {
    _init();
  }
  final List<Transaction> _list = [];

  List<Transaction> get list => _showTransactions();

  void _init() async {
    emit(LoadingStatementState());
    final repository = TransactionDioRepository();
    try {
      final transactions = await repository.getAllTransactions();
      _list.addAll(transactions);

      emit(BothStatementState());
    } catch (e) {
      emit(ErrorStatementState());
    }
  }

  void toggleState(bool isIncome) async {
    if (state is BothStatementState) {
      if (isIncome) {
        emit(ExpenseStatementState());
      } else {
        emit(IncomeStatementState());
      }
    } else if ((state is ExpenseStatementState && isIncome) ||
        (state is IncomeStatementState && !isIncome)) {
      emit(BothStatementState());
    }
  }

  List<Transaction> _showTransactions() {
    if (state is BothStatementState) {
      return _list;
    }
    if (state is IncomeStatementState) {
      return _list.where((element) => element.type == Type.income).toList();
    }
    return _list.where((element) => element.type == Type.expense).toList();
  }
}
