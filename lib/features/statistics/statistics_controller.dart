import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import '../module/data_controller.dart';
import '../module/data_states.dart';
import 'models/section.dart';
import 'statistics_states.dart';

class StatisticsController extends Cubit<StatisticsState> {
  final DataController _dataController;

  StatisticsController(this._dataController) : super(LoadingStatisticsState()) {
    getSections(DateTime.now());
  }

  void getSections(DateTime displayMonth) async {
    emit(LoadingStatisticsState());

    final List<Transaction> monthTransactions;
    final startMonth = displayMonth.month;
    final startYear = displayMonth.year;

    final endMonth = startMonth == 1 ? 12 : startMonth - 1;
    final endYear = startMonth == 1 ? startYear - 1 : startYear;

    final transactionList =
        (_dataController.state as SuccessDataState).transactionList;

    int startIndex = transactionList.indexWhere((element) =>
        element.date.year == startYear && element.date.month == startMonth);
    int endIndex = transactionList.indexWhere((element) =>
        element.date.year == endYear && element.date.month == endMonth);
    if (startIndex == -1) {
      startIndex = transactionList.length;
      endIndex = transactionList.length;
    } else if (endIndex == -1) {
      endIndex = transactionList.length;
    }

    monthTransactions = transactionList.getRange(startIndex, endIndex).toList();

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
