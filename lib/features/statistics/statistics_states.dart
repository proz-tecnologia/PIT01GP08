import 'models/section.dart';

abstract class StatisticsState {}

class LoadingStatisticsState implements StatisticsState {}

class SuccessStatisticsState implements StatisticsState {
  final List<Section> sections;
  final double total;

  SuccessStatisticsState(this.sections, this.total);
}

class ErrorStatisticsState implements StatisticsState {}
