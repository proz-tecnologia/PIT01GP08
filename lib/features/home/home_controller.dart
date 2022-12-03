import 'package:financial_app/features/home/home_states.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:financial_app/shared/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(LoadingHomeState()) {
    _init();
  }
  final List<Transaction> _list = [];

  void _init() async {
    emit(LoadingHomeState());
    final repository = TransactionDioRepository();
    try {
      final transactions = await repository.getAllTransactions();
      _list.addAll(transactions);
      emit(SuccessHomeState());
    } catch (e) {
      emit(ErrorHomeState());
    }
  }

//element.date.isBefore(DateTime.now())
  List<Transaction> displayTransactions() {
    List<Transaction> transactions = [];
    for (var element in _list) {
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
    return transactions.toList();
  }

  double displayBalance(String param) {
    emit(LoadingHomeState());
    double balance = 0;
    double income = 0;
    double expense = 0;
    double pendingIncome = 0;
    double pendingExpense = 0;

    for (var element in _list) {
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
