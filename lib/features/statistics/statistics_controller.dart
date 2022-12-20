import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../module/data_controller.dart';
import '../module/data_states.dart';
import 'models/section.dart';
import 'statistics_states.dart';

import '../../get_month_range.dart';

class StatisticsController extends Cubit<StatisticsState> {
  final DataController _dataController;

  StatisticsController(this._dataController) : super(LoadingStatisticsState()) {
    getSections(DateTime.now());
  }

  void getSections(DateTime displayMonth) async {
    emit(LoadingStatisticsState());

    final monthTransactions = (_dataController.state as SuccessDataState)
        .transactionList
        .getMonthRange(displayMonth);

    final sections = <Section>[];
    double total = 0;

    try {
      final categories =
          (_dataController.state as SuccessDataState).categoryList;
      Map<String, double> map = {};

      for (var transaction in monthTransactions) {
        if (transaction.type == Type.expense) {
          total += transaction.value;
          if (map.containsKey(transaction.categoryId)) {
            map[transaction.categoryId] =
                map[transaction.categoryId]! + transaction.value;
            continue;
          }
          map.addAll({transaction.categoryId: transaction.value});
        }
      }
      for (var entry in map.entries) {
        final category =
            categories.firstWhere((element) => element.id == entry.key);
        sections.add(
          Section(
            entry.value,
            description: category.name,
            color: category.color,
            icon: category.icon,
          ),
        );
      }

      sections.sort((a, b) => b.value.compareTo(a.value));

      for (var s in sections) {
        s.percent = s.value / total * 100;
      }

      emit(SuccessStatisticsState(sections, total));
    } catch (e) {
      emit(ErrorStatisticsState(
          'Não foi possível importar os dados.\nTente novamente.'));
    }
  }
}
