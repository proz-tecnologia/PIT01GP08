extension EndOfMonth on DateTime {
  DateTime endOfMonth() {
    DateTime lastDay = this;
    const oneDay = Duration(days: 1);
    while (lastDay.month == month) {
      lastDay = lastDay.add(oneDay);
    }
    return lastDay.subtract(oneDay);
  }

  String endOfMonthStr() {
    final end = endOfMonth();
    return '${end.day}/$month';
  }
}
