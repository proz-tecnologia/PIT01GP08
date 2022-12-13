import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/category_repository.dart';
import '../../shared/transaction_repository.dart';
import '../../shared/models/transaction.dart';
import 'models/section.dart';
import 'statistics_states.dart';

class StatisticsController extends Cubit<StatisticsState> {
  final CategoryRepository categoryRepo;
  final TransactionRepository transactionRepo;

  StatisticsController(
    this.categoryRepo,
    this.transactionRepo,
  ) : super(LoadingStatisticsState()) {
    _getSections();
  }

  void _getSections() async {
    emit(LoadingStatisticsState());
    final sections = <Section>[];
    double total = 0;
    try {
      final categories = await categoryRepo.getAllCategories();
      final transactions = await transactionRepo.getAllTransactions();
      Map<String, double> map = {};

      for (var transaction in transactions) {
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
      emit(ErrorStatisticsState());
    }
  }
}
