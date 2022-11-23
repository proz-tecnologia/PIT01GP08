import 'dart:math';

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
      _sections.addAll([
        Section(5, description: 'Section 1', color: Colors.blue),
        Section(4, description: 'Section 2', color: Colors.amber),
        Section(3, description: 'Section 3', color: Colors.purple),
        Section(2, description: 'Section 4', color: Colors.green),
        Section(0.5, description: 'Section 5', color: Colors.pink),
      ]);
      _total = _getTotal();
      _setPercents();
      await Future.delayed(const Duration(seconds: 1));

      final random = Random();
      if (random.nextBool() && random.nextBool()) {
        throw Exception();
      }

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
