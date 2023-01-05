import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';

abstract class DataState {}

class LoadingDataState implements DataState {}

class SuccessDataState implements DataState {
  final List<Transaction> transactionList;
  final List<Category> categoryList;
  final String? message;

  SuccessDataState(this.transactionList, this.categoryList, {this.message});
}

class ErrorDataState implements DataState {
  final String message;

  ErrorDataState(this.message);
}
