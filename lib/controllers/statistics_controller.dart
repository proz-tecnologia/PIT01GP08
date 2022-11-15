import 'package:flutter/material.dart';

import '../models/section.dart';

class StatisticsController {
  final _sections = <Section>[];
  late double _total;

  StatisticsController() {
    _getSections();
  }

  List<Section> get sections => _sections;
  double get total => _total;

  void _getSections() {
    _sections.addAll([
      Section(5, color: Colors.blue),
      Section(4, color: Colors.amber),
      Section(3, color: Colors.purple),
      Section(2, color: Colors.green),
    ]);
    _total = _getTotal();
    _setPercents();
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
