abstract class HomeState {}

class LoadingHomeState implements HomeState {}

class SuccessHomeState implements HomeState {
  final double balance;
  final double income;
  final double expense;
  final double pendingIncome;
  final double pendingExpense;

  SuccessHomeState({
    this.balance = 0.0,
    this.income = 0.0,
    this.expense = 0.0,
    this.pendingIncome = 0.0,
    this.pendingExpense = 0.0,
  });

  String get balanceStr => balance.toStringAsFixed(2).replaceAll('.', ',');
  String get incomeStr => income.toStringAsFixed(2).replaceAll('.', ',');
  String get expenseStr => expense.toStringAsFixed(2).replaceAll('.', ',');
  String get pendingIncomeStr =>
      pendingIncome.toStringAsFixed(2).replaceAll('.', ',');
  String get pendingExpenseStr =>
      pendingExpense.toStringAsFixed(2).replaceAll('.', ',');

  SuccessHomeState copyWith({
    double? balance,
    double? income,
    double? expense,
    double? pendingIncome,
    double? pendingExpense,
  }) {
    return SuccessHomeState(
      balance: balance ?? this.balance,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      pendingIncome: pendingIncome ?? this.pendingIncome,
      pendingExpense: pendingExpense ?? this.pendingExpense,
    );
  }
}

class ErrorHomeState implements HomeState {}
