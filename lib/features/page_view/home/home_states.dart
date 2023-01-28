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
}

class ErrorHomeState implements HomeState {}
