import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import 'home_states.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this.transactionList) : super(LoadingHomeState()) {
    displayPending();
    displayTransactions();
  }

  final List<Transaction> transactionList;

  List<Transaction> displayTransactions() {
    List<Transaction> transactions = [];
    for (var element in transactionList) {
      if (element.type == Type.expense) {
        if (!element.fulfilled) {
          transactions.add(element);
        }
      }
    }

    return transactions.reversed.toList().sublist(0, 4);
  }

  void displayPending() {
    // final pendingTransactions =
    //     transactionList.where((element) => !element.fulfilled);
    // final pendingIncome = pendingTransactions
    //     .where((element) => element.type == Type.income)
    //     .fold(0.0, (previousValue, element) => previousValue + element.value);
    // final pendingExpense = pendingTransactions
    //     .where((element) => element.type == Type.expense)
    //     .fold(0.0, (previousValue, element) => previousValue + element.value);

    double pendingIncome = 0;
    double pendingExpense = 0;
    final pendingTransactions =
        transactionList.where((element) => !element.fulfilled);
    for (var element in pendingTransactions) {
      if (element.type == Type.income) {
        pendingIncome += element.value;
      } else {
        pendingExpense += element.value;
      }
    }

    emit(
      SuccessHomeState(
        pendingExpense: pendingExpense,
        pendingIncome: pendingIncome,
      ),
    );
  }
}

class HomeController2 extends Cubit<HomeState> {
  HomeController2(this.transactionList) : super(LoadingHomeState());

  final List<Transaction> transactionList;

  void displayBalance(DateTime displayMonth) {
    emit(LoadingHomeState());

    final List<Transaction> monthTransactionList;
    final startMonth = displayMonth.month;
    final startYear = displayMonth.year;
    final today = DateTime.now();

    if (today.year == startYear && today.month == startMonth) {
      monthTransactionList = transactionList;
    } else {
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
    }

    double income = 0;
    double expense = 0;
    for (var element in monthTransactionList) {
      if (element.type == Type.income) {
        income += element.value;
      } else {
        expense += element.value;
      }
    }

    final balance = income - expense;

    emit(
      SuccessHomeState(
        balance: balance,
        income: income,
        expense: expense,
      ),
    );
  }
}
