import 'package:dio/dio.dart';

import 'models/category.dart';

const categoriesUrl =
    'https://mockend.com/rudarabello/flutter_dio_challenge/categorys';

abstract class CategoryRepository {
  Future<bool> createCategory(Category category);
  Future<Category?> getCategoryData(int id);
  Future<bool> editCategoryData(Category category);
  Future<bool> deleteCategory(int id);
  Future<List<Category>> getAllCategories();
}

class CategoryDioRepository implements CategoryRepository {
  final _dio = Dio();

  @override
  Future<bool> createCategory(Category category) async {
    final response = await _dio.post(categoriesUrl, data: category.toMap());
    return response.statusCode == 201;
  }

  @override
  Future<bool> deleteCategory(int id) async {
    final response = await _dio.delete('$categoriesUrl/$id');
    return response.statusCode == 204;
  }

  @override
  Future<bool> editCategoryData(Category category) async {
    final response =
        await _dio.put('$categoriesUrl/${category.id}', data: category.toMap());
    return response.statusCode == 200;
  }

  @override
  Future<Category?> getCategoryData(int id) async {
    final response = await _dio.get('$categoriesUrl/$id');
    if (response.statusCode == 200) {
      return Category.fromMap(response.data);
    }
    return null;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final response = await _dio.get(categoriesUrl);
    if (response.statusCode == 200) {
      final List list = response.data;
      return List<Category>.from(list.map((e) => Category.fromMap(e)));
    }
    return [];
  }
}
