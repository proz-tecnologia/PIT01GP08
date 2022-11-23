import 'package:flutter/material.dart';

import 'models/section.dart';
import 'statistics_states.dart';

class StatisticsController {
  final _sections = <Section>[];
  late double _total;
  final touchedIndex = ValueNotifier(-1);
  final state = ValueNotifier<StatisticsState>(InitialStatisticsState());

  StatisticsController._() {
    _getSections();
  }

  factory StatisticsController() {
    return StatisticsController._();
  }

  List<Section> get sections => _sections;
  double get total => _total;

  void _getSections() async {
    state.value = LoadingStatisticsState();
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
      await Future.delayed(const Duration(seconds: 2));
      state.value = SuccessStatisticsState();
    } catch (e) {
      state.value = ErrorStatisticsState();
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

  void dispose() {
    StatisticsController().dispose();
    touchedIndex.dispose();
  }
}
