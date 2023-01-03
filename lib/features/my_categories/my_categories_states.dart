import '../../shared/models/category.dart';

abstract class MyCategoriesState {}

class LoadingMyCategoriesState extends MyCategoriesState {}

class SuccessMyCategoriesState extends MyCategoriesState {
  final List<Category> list;

  SuccessMyCategoriesState(this.list);
}

class ErrorMyCategoriesState extends MyCategoriesState {
  final String message;

  ErrorMyCategoriesState(this.message);
}

class SavingMyCategoriesState extends MyCategoriesState {}

class SaveErrorMyCategoriesState extends MyCategoriesState {
  final String message;

  SaveErrorMyCategoriesState(this.message);
}
