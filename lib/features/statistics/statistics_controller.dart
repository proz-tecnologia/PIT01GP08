import 'dart:math';

import 'package:financial_app/shared/category_repository.dart';
import 'package:financial_app/shared/models/category.dart';
import 'package:financial_app/shared/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/section.dart';
import 'statistics_states.dart';

class StatisticsController extends Cubit<StatisticsState> {
  final _sections = <Section>[];
  late double _total;

  StatisticsController() : super(LoadingStatisticsState()) {
    _getSections();
  }

  List<Section> get sections => _sections;
  double get total => _total;

  void _getSections() async {
    emit(LoadingStatisticsState());
    try {
      // trocar pela chamada da api;
      // - pegar despesas do mês
      // - separar em categorias
      // - gerar seções com base nos valores totais
      // _sections.addAll([
      //   Section(5, description: 'Section 1', color: Colors.blue),
      //   Section(4, description: 'Section 2', color: Colors.amber),
      //   Section(3, description: 'Section 3', color: Colors.purple),
      //   Section(2, description: 'Section 4', color: Colors.green),
      //   Section(0.5, description: 'Section 5', color: Colors.pink),
      // ]);
      final categories = await CategoryDioRepository().getAllCategories();
      final transactions =
          await TransactionDioRepository().getAllTransactions();
      Map<int, double> map = {};

      for (var transaction in transactions) {
        if (map.containsKey(transaction.categoryId)) {
          map[transaction.categoryId] =
              map[transaction.categoryId]! + transaction.value;
        }
        map.addAll({transaction.categoryId: transaction.value});
      }
      for (var entry in map.entries) {
        final category =
            categories.firstWhere((element) => element.id == entry.key);
        _sections.add(
          Section(entry.value,
              description: category.name, color: category.color),
        );
      }

      _total = _getTotal();
      _setPercents();

      // para testes de gerência de estado:
      // await Future.delayed(const Duration(seconds: 1));
      // final random = Random();
      // if (random.nextBool() && random.nextBool()) {
      //   throw Exception();
      // }

      emit(SuccessStatisticsState());
    } catch (e) {
      emit(ErrorStatisticsState());
    }
  }

  double _getTotal() {
    double total = 0;
    for (var s in _sections) {
      total += s.value;
    }
    return total;
  }

  void _setPercents() {
    for (var s in _sections) {
      s.percent = s.value / _total * 100;
    }
  }
}
