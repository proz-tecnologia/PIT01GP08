import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/models/transaction.dart';
import 'statement_states.dart';

class StatementController extends Cubit<StatementState> {
  StatementController() : super(LoadingStatementState()) {
    init();
  }
  final List<Transaction> _list = [];

  List<Transaction> get list => _list;

  void init() async {
    emit(LoadingStatementState());
    try {
      final list = await _getTransactions();
      _list.addAll(list);

      // para testes de gerência de estado:
      await Future.delayed(const Duration(seconds: 1));
      final random = Random();
      if (random.nextBool() && random.nextBool()) {
        throw Exception();
      }

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
    final list = await _getTransactions();
    _list.clear();
    _list.addAll(list);
  }

  Future<List<Transaction>> _getTransactions() async {
    if (_list.isEmpty || state is BothStatementState) {
      // TODO: trocar pela requisição na API
      return _mock;
    }
    if (state is IncomeStatementState) {
      // TODO: trocar pela requisição na API
      return _mock.where((element) => element.type == 'income').toList();
    }
    // TODO: trocar pela requisição na API
    return _mock.where((element) => element.type == 'expense').toList();
  }
}

final List<Transaction> _mock = [
  Transaction(
    date: DateTime.now().add(const Duration(days: 2)),
    description: 'Exemplo de despesa futura',
    value: 100.5,
    type: Type.expense,
  ),
  Transaction(
    date: DateTime.now().add(const Duration(days: 2)),
    description: 'Exemplo de receita futura',
    value: 300.25,
    type: Type.income,
  ),
  Transaction(
    date: DateTime.now(),
    description: 'Exemplo de despesa hoje',
    value: 200.25,
    type: Type.expense,
  ),
  Transaction(
    date: DateTime.now(),
    description: 'Exemplo de receita hoje',
    value: 200.5,
    type: Type.income,
  ),
  Transaction(
    date: DateTime.now().subtract(const Duration(days: 5)),
    description: 'Exemplo de despesa passada',
    value: 300,
    type: Type.expense,
  ),
  Transaction(
    date: DateTime.now().subtract(const Duration(days: 5)),
    description: 'Exemplo de receita passada',
    value: 100.75,
    type: Type.income,
  ),
];
