import 'package:financial_app/features/page_view/home/home_controller.dart';
import 'package:financial_app/features/page_view/home/home_states.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<Transaction> list = [];
  final controller = HomeController(list);

  setUp(() {
    list = [];
  });
  group('displayTransactions()', () {
    test('empty list', () {
      final result = controller.displayTransactions();
      expect(result.length, 0);
    });
  });

  group('displayBalance()', () {
    test('empty list', () {
      controller.displayBalance();
      expect(controller.state, isA<SuccessHomeState>());
    });
  });
}
