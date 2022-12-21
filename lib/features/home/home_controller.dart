import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import 'home_states.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this.transactionList) : super(LoadingHomeState()) {
    displayTransactions();
    displayBalance();
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

  void displayBalance() {
    double income = 0;
    double expense = 0;
    double pendingIncome = 0;
    double pendingExpense = 0;
    
    for (var element in transactionList) {
      if (element.type == Type.income) {
        income += element.value;
        if (!element.fulfilled) {
          pendingIncome += element.value;
        }
      } else {
        expense += element.value;
        if (!element.fulfilled) {
          pendingExpense += element.value;
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
