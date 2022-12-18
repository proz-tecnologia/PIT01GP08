import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import '../module/data_controller.dart';
import '../module/data_states.dart';
import 'home_states.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this._dataController) : super(LoadingHomeState());

  final DataController _dataController;

//element.date.isBefore(DateTime.now())
  List<Transaction> displayTransactions() {
    List<Transaction> transactions = [];
    for (var element
        in (_dataController.state as SuccessDataState).transactionList) {
      if (element.type == Type.expense) {
        if (!element.fulfilled) {
          transactions.add(element);
        }
      }
    }

    transactions.sort(
      (a, b) {
        int aDate = a.date.millisecondsSinceEpoch;
        int bDate = b.date.millisecondsSinceEpoch;
        return aDate.compareTo(bDate);
      },
    );
    emit(SuccessHomeState());
    return transactions.toList();
  }

  double displayBalance(String param) {
    emit(LoadingHomeState());
    double balance = 0;
    double income = 0;
    double expense = 0;
    double pendingIncome = 0;
    double pendingExpense = 0;

    for (var element
        in (_dataController.state as SuccessDataState).transactionList) {
      if (element.type == Type.income) {
        balance += element.value;
        income += element.value;
        if (!element.fulfilled) {
          pendingIncome += element.value;
        }
      } else {
        balance -= element.value;
        expense += element.value;
        if (!element.fulfilled) {
          pendingExpense += element.value;
        }
      }
    }
    emit(SuccessHomeState());
    switch (param) {
      case 'balance':
        return balance;
      case 'income':
        return income;
      case 'expense':
        return expense;
      case 'pendingIncome':
        return pendingIncome;
      case 'pendingExpense':
        return pendingExpense;
      default:
        emit(ErrorHomeState());
    }
    return 0;
  }
}
