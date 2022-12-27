import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/category.dart';

abstract class CategoryRepository {
  Future<bool> createCategory(Category category);
  Future<Category?> getCategoryData(String id);
  Future<bool> editCategoryData(Category category);
  Future<bool> deleteCategory(String id);
  Future<List<Category>> getAllCategories();
  Future<void> setInitialCategories(String uid);
}

class CategoryFirebaseRepository implements CategoryRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
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

  @override
  Future<void> setInitialCategories(String uid) async {
    try {
      final newPath = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('categories');
      final snapshot = await FirebaseFirestore.instance
          .collection('initialCategories')
          .get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        newPath.add(doc.data());
      }
    } catch (e) {
      rethrow;
    }
  }
}
