import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/category.dart';

abstract class CategoryRepository {
  Future<void> createCategory(Category category);
  Future<void> editCategoryData(Category category);
  Future<void> deleteCategory(String id);
  Future<List<Category>> getAllCategories();
  Future<void> setInitialCategories(String uid);
}

class CategoryFirebaseRepository implements CategoryRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('categories');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await firestorePath.add(category.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await firestorePath.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editCategoryData(Category category) async {
    try {
      await firestorePath.doc(category.id).set(category.toMap());
    } catch (e) {
      rethrow;
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
