import 'dart:math';

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
      log(_list as num);
      emit(SuccessHomeState());
    } catch (e) {
      emit(ErrorHomeState());
    }
  }

  double displayBalance(String param) {
    double balance = 0;
    double income = 0;
    double expense = 0;

    for (var element in _list) {
      if (element.type == Type.income) {
        balance += element.value;
        income += element.value;
      } else {
        balance -= element.value;
        expense += element.value;
      }
    }
    switch (param) {
      case 'balance':
        return balance;
      case 'income':
        return income;
      case 'expense':
        return expense;
      default:
        return balance;
    }
  }
}
