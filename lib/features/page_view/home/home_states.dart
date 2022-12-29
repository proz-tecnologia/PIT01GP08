abstract class HomeState {}

class LoadingHomeState implements HomeState {}

class SuccessHomeState implements HomeState {
  final double balance;
  final double income;
  final double expense;
  final double pendingIncome;
  final double pendingExpense;

  SuccessHomeState({
    required this.balance,
    required this.income,
    required this.expense,
    required this.pendingIncome,
    required this.pendingExpense,
  });

  String get balanceStr =>
      'R\$ ${balance.toStringAsFixed(2).replaceAll('.', ',')}';
  String get incomeStr =>
      'R\$ ${income.toStringAsFixed(2).replaceAll('.', ',')}';
  String get expenseStr =>
      'R\$ ${expense.toStringAsFixed(2).replaceAll('.', ',')}';
  String get pendingIncomeStr =>
      'R\$ ${pendingIncome.toStringAsFixed(2).replaceAll('.', ',')}';
  String get pendingExpenseStr =>
      'R\$ ${pendingExpense.toStringAsFixed(2).replaceAll('.', ',')}';
}

class ErrorHomeState implements HomeState {}
