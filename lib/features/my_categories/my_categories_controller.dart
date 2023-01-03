import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_repository.dart';
import '../../shared/models/category.dart';
import 'my_categories_states.dart';

class MyCategoriesController extends Cubit<MyCategoriesState> {
  static MyCategoriesController instance(CategoryRepository repository) =>
      MyCategoriesController._(repository);

  MyCategoriesController._(this.repository)
      : super(LoadingMyCategoriesState()) {
    init();
  }

  final CategoryRepository repository;

  void init() async {
    emit(LoadingMyCategoriesState());
    try {
      final list = await repository.getAllCategories();
      emit(SuccessMyCategoriesState(list));
    } catch (e) {
      emit(ErrorMyCategoriesState('Não foi possível\ncarregar os dados.'));
    }
  }

  void saveCategory(
    String? id, {
    required Color color,
    required String name,
    required Type type,
    required IconData icon,
  }) async {
    List<Category> list = (state as SuccessMyCategoriesState).list;
    emit(SavingMyCategoriesState());
    try {
      final newCategory = Category(
        id: id,
        color: color,
        name: name,
        type: type,
        icon: icon,
      );
      if (id == null) {
        await repository.createCategory(newCategory);
        list.add(newCategory);
      } else {
        await repository.editCategoryData(newCategory);
        list[list.indexWhere((category) => category.id == id)] = newCategory;
      }
      emit(SuccessMyCategoriesState(list));
    } catch (e) {
      emit(SaveErrorMyCategoriesState('Algo deu errado. Tente novamente.'));
    }
  }
}
