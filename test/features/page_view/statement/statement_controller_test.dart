import 'package:financial_app/features/page_view/statement/statement_controller.dart';
import 'package:financial_app/features/page_view/statement/statement_states.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final list = <Transaction>[];
  StatementController controller = StatementController(list);
  group('toggleState()', () {
    setUp(() {
      controller = StatementController(list);
    });

    test('from both, click on expense', () {
      controller.toggleState(false);
      expect(controller.state, isA<IncomeStatementState>());
    });

    test('from both, click on income', () {
      controller.toggleState(true);
      expect(controller.state, isA<ExpenseStatementState>());
    });
  });
}
