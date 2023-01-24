import 'package:financial_app/features/page_view/statistics/statistics_controller.dart';
import 'package:financial_app/features/page_view/statistics/statistics_states.dart';
import 'package:financial_app/shared/models/category.dart';
import 'package:financial_app/shared/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<Transaction> transactionList = [];
  List<Category> categoryList = [];
  StatisticsController controller =
      StatisticsController(transactionList, categoryList);
  final displayMonth = DateTime(2023, 1);
  final exampleCategory = Category(
      id: 'catId',
      color: Colors.black,
      name: 'name',
      type: Type.income,
      icon: Icons.abc);
  final exampleTransaction = Transaction.fromCategory(
      date: displayMonth,
      description: 'description',
      value: 10,
      category: exampleCategory,
      fulfilled: true,
      payment: Payment.normal);

  group('getSections()', () {
    setUp(() {
      transactionList = [];
      categoryList = [];
      controller = StatisticsController(transactionList, categoryList);
    });

    test('empty list', () {
      controller.getSections(displayMonth);
      expect(controller.state, isA<SuccessStatisticsState>());
      if (controller.state is SuccessStatisticsState) {
        expect((controller.state as SuccessStatisticsState).sections.length, 0);
        expect((controller.state as SuccessStatisticsState).total, 0);
      }
    });

    test('one income', () {
      categoryList.add(exampleCategory);
      transactionList.add(exampleTransaction);
      controller.getSections(displayMonth);
      expect(controller.state, isA<SuccessStatisticsState>());
      if (controller.state is SuccessStatisticsState) {
        expect((controller.state as SuccessStatisticsState).sections.length, 0);
        expect((controller.state as SuccessStatisticsState).total, 0);
      }
    });

    test('one expense', () {
      categoryList.add(exampleCategory.copyWith(type: Type.expense));
      transactionList.add(exampleTransaction.copyWith(type: Type.expense));
      controller.getSections(displayMonth);
      expect(controller.state, isA<SuccessStatisticsState>());
      if (controller.state is SuccessStatisticsState) {
        expect((controller.state as SuccessStatisticsState).sections.length, 1);
        expect((controller.state as SuccessStatisticsState).total, 10);
      }
    });
  });
}
