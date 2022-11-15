import 'package:flutter/material.dart';

import '../models/section.dart';

class StatisticsController {
  final _sections = <Section>[];

  StatisticsController() {
    _getSections();
  }

  List<Section> get sections {
    return _sections;
  }

  void _getSections() {
    _sections.addAll([
      Section(5, color: Colors.blue),
      Section(4, color: Colors.amber),
      Section(3, color: Colors.purple),
      Section(2, color: Colors.green),
    ]);
    _setPercents();
  }

  double getTotal() {
    double total = 0;
    for (var s in _sections) {
      total += s.value;
    }
    return total;
  }

  void _setPercents() {
    double total = getTotal();
    for (var s in _sections) {
      s.percent = s.value / total * 100;
    }
  }
}
