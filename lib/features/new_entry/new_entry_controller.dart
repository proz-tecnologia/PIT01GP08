import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart' as tmodel;
import '../../shared/transaction_repository.dart';
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
  }) async {
    final lastTypeState = state;
    emit(SavingNewEntryState());

    try {
      final date = DateTime(
        int.parse(dateString.substring(6)),
        int.parse(dateString.substring(3, 5)),
        int.parse(dateString.substring(0, 2)),
      );
      final type = category!.type == Type.income
          ? tmodel.Type.income
          : tmodel.Type.expense;
      final payment = paymentOption == 0
          ? tmodel.Payment.normal
          : paymentOption == 1
              ? tmodel.Payment.fixed
              : tmodel.Payment.parcelled;

      final newTransaction = tmodel.Transaction(
        date: date,
        description: description,
        value: double.parse(value),
        type: type,
        categoryId: category.id!,
        fulfilled: fulfilled,
        payment: payment,
      );

      final success =
          await transactionRepository.createTransaction(newTransaction);

      if (success) {
        emit(SuccessNewEntryState());
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(ErrorNewEntryState());
      emit(lastTypeState);
    }
  }
}

class NewEntryTypeController extends Cubit<NewEntryTypeState> {
  final List<Category> categoryList;

  NewEntryTypeController(this.categoryList)
      : super(ExpenseNewEntryState(
          categoryList
              .where((category) => category.type == Type.expense)
              .toList(),
        ));

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
