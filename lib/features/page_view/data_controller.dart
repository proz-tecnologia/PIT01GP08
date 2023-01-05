import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_repository.dart';
import '../../services/transaction_repository.dart';
import '../../shared/models/transaction.dart';
import 'data_states.dart';

class DataController extends Cubit<DataState> {
  DataController({
    required this.transactionRepo,
    required this.categoryRepo,
  }) : super(LoadingDataState()) {
    _init();
  }

  final TransactionRepository transactionRepo;
  final CategoryRepository categoryRepo;

  void _init() async {
    emit(LoadingDataState());
    try {
      final transactions = await transactionRepo.getAllTransactions();
      final categories = await categoryRepo.getAllCategories();

      emit(SuccessDataState(transactions, categories));
      return;
    } catch (e) {
      emit(ErrorDataState('Falha ao carregar os dados.'));
    }
  }

  void fulfillTransaction(Transaction transaction) async {
    final categories = (state as SuccessDataState).categoryList;
    List<Transaction> transactions =
        (state as SuccessDataState).transactionList;
    try {
      await transactionRepo.fulfillTransaction(transaction);
      transaction.fulfill();
    } catch (e) {
      emit(SuccessDataState(transactions, categories,
          message: 'Não foi possível salvar os dados.\nTente novamente.'));
    }
  }
}
