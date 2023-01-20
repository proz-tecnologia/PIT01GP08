import 'package:financial_app/shared/models/category.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:financial_app/shared/utils/select_by_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final list = <Transaction>[];
  final january = DateTime(2023, 1, 15);
  final exampleTransaction = Transaction(
      date: january,
      description: 'description',
      value: 1.0,
      type: Type.expense,
      categoryId: 'categoryId',
      fulfilled: true,
      payment: Payment.normal);

  group('getMonthRange()', () {
    test('empty list', () {
      final result = list.getMonthRange(january);
      expect(result.isEmpty, true);
    });

    test('no transaction in month', () {
      list.add(exampleTransaction.copyWith(date: DateTime(2022)));
      list.add(exampleTransaction.copyWith(date: DateTime(2023, 2)));
      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));

      final result = list.getMonthRange(january);
      expect(result.isEmpty, true);
    });

    test('month out of list range', () {
      list.add(exampleTransaction.copyWith(date: DateTime(2022)));
      list.add(exampleTransaction.copyWith(date: DateTime(2022, 12)));
      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));

      final result = list.getMonthRange(january);
      expect(result.isEmpty, true);
    });

    test('one element selected', () {
      list.add(exampleTransaction.copyWith(date: DateTime(2022)));
      list.add(exampleTransaction.copyWith(date: DateTime(2022, 12)));
      list.add(exampleTransaction.copyWith(date: DateTime(2023, 2)));
      list.add(exampleTransaction.copyWith(date: DateTime(2023, 1)));
      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));

      final result = list.getMonthRange(january);
      expect(result.length, 1);
      expect(result[0].date, DateTime(2023, 1));
    });
  });
}
