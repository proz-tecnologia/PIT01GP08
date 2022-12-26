import 'package:flutter/material.dart';

import 'models/section.dart';

abstract class StatisticsState {}

class LoadingStatisticsState implements StatisticsState {}

class SuccessStatisticsState implements StatisticsState {
  final List<Section> sections;
  final double total;
  final touchedIndex = ValueNotifier(-1);

  SuccessStatisticsState(this.sections, this.total);
}

class ErrorStatisticsState implements StatisticsState {
  final String message;

  ErrorStatisticsState(this.message);
}
