import '../models/transaction.dart';

extension SelectByDate on List<Transaction> {
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

  List<Transaction> getUntilDate(DateTime limitDate) {
    int startIndex = indexWhere((element) => !element.date.isAfter(limitDate));

    if (startIndex == -1) {
      return [];
    }

    return getRange(startIndex, length - 1).toList();
  }

  List<Transaction> getUntilMonth(DateTime displayMonth) {
    final startMonth = displayMonth.month;
    final startYear = displayMonth.year;

    int startIndex = indexWhere((element) =>
        element.date.year == startYear && element.date.month == startMonth);

    if (startIndex == -1) {
      return [];
    }

    return getRange(startIndex, length - 1).toList();
  }
}
