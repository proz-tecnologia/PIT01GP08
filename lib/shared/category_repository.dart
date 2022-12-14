import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/category.dart';

const categoriesUrl =
    'https://mockend.com/rudarabello/flutter_dio_challenge/categorys';

abstract class CategoryRepository {
  Future<bool> createCategory(Category category);
  Future<Category?> getCategoryData(String id);
  Future<bool> editCategoryData(Category category);
  Future<bool> deleteCategory(String id);
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
  Future<bool> deleteCategory(String id) async {
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
  Future<Category?> getCategoryData(String id) async {
    final response = await _dio.get('$categoriesUrl/$id');
    if (response.statusCode == 200) {
      return Category.fromMap(id, response.data);
    }
    return null;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final response = await _dio.get(categoriesUrl);
    if (response.statusCode == 200) {
      final List list = response.data;
      return List<Category>.from(list.map((e) => Category.fromMap(e['id'], e)));
    }
    return [];
  }
}

class CategoryFirebaseRepository implements CategoryRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      //.doc(FirebaseAuth.instance.currentUser!.uid)
      .doc('sUWdyeTWkHWy0PupifIhggoPeJ32')
      .collection('categories');

  @override
  Future<bool> createCategory(Category category) async {
    try {
      firestorePath.add(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteCategory(String id) async {
    try {
      firestorePath.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editCategoryData(Category category) async {
    try {
      firestorePath.doc(category.id).set(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final list = <Category>[];
    try {
      final snapshot = await firestorePath.get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        list.add(
          Category.fromMap(doc.id, doc.data()),
        );
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Category?> getCategoryData(String id) async {
    try {
      final snapshot = await firestorePath.doc(id).get();
      final data = snapshot.data()!;
      return Category.fromMap(id, data);
    } catch (e) {
      return null;
    }
  }
}
