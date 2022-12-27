import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/category.dart';
import '../../../shared/models/transaction.dart';
import '../../../shared/utils/select_by_date.dart';
import 'models/section.dart';
import 'statistics_states.dart';

class StatisticsController extends Cubit<StatisticsState> {
  final List<Transaction> transactionList;
  final List<Category> categoryList;

  StatisticsController(this.transactionList, this.categoryList)
      : super(LoadingStatisticsState()) {
    getSections(DateTime.now());
  }

  void getSections(DateTime displayMonth) {
    emit(LoadingStatisticsState());

    final monthTransactions = transactionList.getMonthRange(displayMonth);

    final sections = <Section>[];
    double total = 0;

    try {
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
            categoryList.firstWhere((element) => element.id == entry.key);
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
