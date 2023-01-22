import 'package:financial_app/features/new_entry/new_entry_controller.dart';
import 'package:financial_app/features/new_entry/new_entry_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  NewEntryTypeController controller = NewEntryTypeController([]);

  setUp(() {
    controller = NewEntryTypeController([]);
  });

  group('changeType()', () {
    test('expense to income', () {
      controller.changeType(isIncome: true);
      expect(controller.state, isA<IncomeNewEntryState>());
    });

    test('income to expense', () {
      controller.changeType(isIncome: true);
      expect(controller.state, isA<IncomeNewEntryState>());
      controller.changeType(isIncome: false);
      expect(controller.state, isA<ExpenseNewEntryState>());
    });

    test('click without changing', () {
      expect(controller.state, isA<ExpenseNewEntryState>());
      controller.changeType(isIncome: false);
      expect(controller.state, isA<ExpenseNewEntryState>());
    });
  });
}
