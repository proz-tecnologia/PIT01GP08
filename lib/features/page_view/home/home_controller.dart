import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/category.dart';
import '../../../shared/models/transaction.dart';
import '../../../shared/utils/select_by_date.dart';
import 'home_states.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this.transactionList) : super(LoadingHomeState()) {
    displayBalance();
  }

  final List<Transaction> transactionList;
  final ValueNotifier<bool> isVisible = ValueNotifier(true);

  List<Transaction> displayTransactions() {
    List<Transaction> transactions = [];
    for (var element in transactionList) {
      if (element.type == Type.expense) {
        if (!element.fulfilled) {
          transactions.add(element);
        }
      }
    }

    if (transactions.length < 4) {
      return transactions.reversed.toList();
    }
    return transactions.reversed.toList().sublist(0, 4);
  }

  void displayBalance() {
    double income = 0;
    double expense = 0;
    double pendingIncome = 0;
    double pendingExpense = 0;

    final today = DateTime.now();
    final untilCurrentMonth = transactionList.getUntilMonth(today);

    for (var transaction in untilCurrentMonth) {
      if (transaction.type == Type.income) {
        if (!transaction.date.isAfter(today)) {
          income += transaction.value;
        }
        if (!transaction.fulfilled) {
          pendingIncome += transaction.value;
        }
      } else {
        if (!transaction.date.isAfter(today)) {
          expense += transaction.value;
        }
        if (!transaction.fulfilled) {
          pendingExpense += transaction.value;
        }
      }
    }

    final balance = income - expense;

    emit(
      SuccessHomeState(
        balance: balance,
        income: income,
        expense: expense,
        pendingExpense: pendingExpense,
        pendingIncome: pendingIncome,
      ),
    );
  }
}
