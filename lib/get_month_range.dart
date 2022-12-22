import 'shared/models/transaction.dart';

extension monthSelect on List<Transaction> {
  List<Transaction> getMonthRange(DateTime displayMonth) {
    final startMonth = displayMonth.month;
    final startYear = displayMonth.year;

    final endMonth = startMonth == 1 ? 12 : startMonth - 1;
    final endYear = startMonth == 1 ? startYear - 1 : startYear;

    int startIndex = indexWhere((element) =>
        element.date.year == startYear && element.date.month == startMonth);
    int endIndex = indexWhere((element) =>
        element.date.year == endYear && element.date.month == endMonth);
    if (startIndex == -1) {
      startIndex = length;
      endIndex = length;
    } else if (endIndex == -1) {
      endIndex = length;
    }

    return getRange(startIndex, endIndex).toList();
  }
}
