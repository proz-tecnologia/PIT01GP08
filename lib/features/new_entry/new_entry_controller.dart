import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import '../../services/transaction_repository.dart';
import 'new_entry_states.dart';

class NewEntryController extends Cubit<NewEntryState> {
  final TransactionRepository transactionRepository;

  NewEntryController(this.transactionRepository)
      : super(InitialNewEntryState());

  void saveTransaction({
    required String dateString,
    required String description,
    required String value,
    required Category? category,
    required bool fulfilled,
    required int paymentOption,
    String endDateString = '',
    String partsString = '',
  }) async {
    final lastTypeState = state;
    emit(SavingNewEntryState());

    try {
      final date = DateTime(
        int.parse(dateString.substring(6)),
        int.parse(dateString.substring(3, 5)),
        int.parse(dateString.substring(0, 2)),
      );
      final endDate = endDateString == ''
          ? null
          : DateTime(
              int.parse(endDateString.substring(6)),
              int.parse(endDateString.substring(3, 5)),
              int.parse(endDateString.substring(0, 2)),
            );
      final payment = Payment.values[paymentOption];

      final newTransaction = Transaction.fromCategory(
        date: date,
        description: description,
        value: double.parse(
          value
              .replaceAll(RegExp('[R\$]'), '')
              .replaceAll('.', '')
              .replaceAll(',', '.'),
        ),
        category: category!,
        fulfilled: fulfilled,
        payment: payment,
        endDate: endDate,
        parts: int.tryParse(partsString) ?? 2,
      );

      await transactionRepository.createTransaction(newTransaction);
      emit(SuccessNewEntryState());
    } catch (e) {
      emit(ErrorNewEntryState());
      emit(lastTypeState);
    }
  }
}

class NewEntryTypeController extends Cubit<NewEntryTypeState> {
  final List<Category> categoryList;

  NewEntryTypeController(this.categoryList)
      : super(
          ExpenseNewEntryState(
            categoryList
                .where((category) => category.type == Type.expense)
                .toList(),
          ),
        );

  void changeType({required bool isIncome}) {
    if (isIncome && state is ExpenseNewEntryState) {
      emit(
        IncomeNewEntryState(
          categoryList
              .where((category) => category.type == Type.income)
              .toList(),
        ),
      );
    } else if (state is IncomeNewEntryState) {
      emit(
        ExpenseNewEntryState(
          categoryList
              .where((category) => category.type == Type.expense)
              .toList(),
        ),
      );
    }
  }
}
