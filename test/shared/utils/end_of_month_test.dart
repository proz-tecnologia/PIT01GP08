import 'package:financial_app/shared/utils/end_of_month.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('endOfMonthStr()', () {
    test('from first day of month', () {
      final januaryFirst = DateTime(2023, 1, 1);
      String result = januaryFirst.endOfMonthStr();
      expect(result, '31/1');

      final februaryFirst = DateTime(2023, 2, 1);
      result = februaryFirst.endOfMonthStr();
      expect(result, '28/2');
    });

    test('february - leap year', () {
      final februaryFirst = DateTime(2020, 2, 1);
      final result = februaryFirst.endOfMonthStr();
      expect(result, '29/2');
    });
  });
}
