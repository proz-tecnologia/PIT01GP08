import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/category.dart';
import '../../../shared/models/transaction.dart';
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
    double balance = 0;
    double income = 0;
    double expense = 0;
    double pendingIncome = 0;
    double pendingExpense = 0;

    final today = DateTime.now();
    final nextMonth = DateTime(today.year, today.month + 1);

    for (var transaction in transactionList) {
      if (transaction.fulfilled) {
        if (transaction.type == Type.income) {
          balance += transaction.value;
        } else {
          balance -= transaction.value;
        }
      } else if (transaction.date.isBefore(nextMonth)) {
        if (transaction.type == Type.income) {
          pendingIncome += transaction.value;
        } else {
          pendingExpense += transaction.value;
        }
      }
      if (transaction.date.month == today.month) {
        if (transaction.type == Type.income) {
          income += transaction.value;
        } else {
          expense += transaction.value;
        }
      }
    }

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
