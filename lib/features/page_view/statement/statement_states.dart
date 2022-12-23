import '../shared/models/transaction.dart';
import '../shared/models/category.dart';

abstract class StatementState {
  final List<Transaction> list;

  StatementState(this.list);

  StatementState copyWith(List<Transaction> newList);
}

class IncomeStatementState implements StatementState {
  @override
  final List<Transaction> list;

  IncomeStatementState(List<Transaction> list)
      : list = list.where((element) => element.type == Type.income).toList();

  @override
  StatementState copyWith(List<Transaction> newList) =>
      IncomeStatementState(newList);
}

class ExpenseStatementState implements StatementState {
  @override
  final List<Transaction> list;

  ExpenseStatementState(List<Transaction> list)
      : list = list.where((element) => element.type == Type.expense).toList();

  @override
  StatementState copyWith(List<Transaction> newList) =>
      ExpenseStatementState(newList);
}

class BothStatementState implements StatementState {
  @override
  final List<Transaction> list;

  BothStatementState(this.list);

  @override
  StatementState copyWith(List<Transaction> newList) =>
      BothStatementState(newList);
}
