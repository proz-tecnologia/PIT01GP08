import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/transaction.dart';
import '../module/data_controller.dart';
import '../module/data_states.dart';
import 'statement_states.dart';

class StatementController extends Cubit<StatementState> {
  StatementController(this._dataController) : super(BothStatementState());

  final DataController _dataController;
  List<Transaction> get list => _showTransactions();

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
    final list = (_dataController.state as SuccessDataState).transactionList;
    if (state is BothStatementState) {
      return list;
    }
    if (state is IncomeStatementState) {
      return list.where((element) => element.type == Type.income).toList();
    }
    return list.where((element) => element.type == Type.expense).toList();
  }
}
