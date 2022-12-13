import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/category_repository.dart';
import '../../shared/transaction_repository.dart';
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
      //final categories = await categoryRepo.getAllCategories();
      emit(
        //SuccessDataState(transactions, categories),
        SuccessDataState(transactions, []),
      );
      return;
    } catch (e) {
      emit(ErrorDataState('Falha ao carregar os dados.'));
    }
  }
}
