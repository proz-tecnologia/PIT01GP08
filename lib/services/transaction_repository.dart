import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/transaction.dart' as model;

abstract class TransactionRepository {
  Future<bool> createTransaction(model.Transaction transaction);
  Future<model.Transaction?> getTransactionData(String id);
  Future<bool> editTransactionData(model.Transaction transaction);
  Future<bool> deleteTransaction(String id);
  Future<List<model.Transaction>> getAllTransactions();
}

class TransactionFirebaseRepository implements TransactionRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('transactions');

  @override
  Future<bool> createTransaction(model.Transaction transaction) async {
    try {
      firestorePath.add(transaction.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTransaction(String id) async {
    try {
      firestorePath.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editTransactionData(model.Transaction transaction) async {
    try {
      firestorePath.doc(transaction.id).set(transaction.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<model.Transaction>> getAllTransactions() async {
    final list = <model.Transaction>[];
    try {
      final snapshot =
          await firestorePath.orderBy("date", descending: true).get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        list.add(
          model.Transaction.fromMap(doc.id, doc.data()),
        );
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<model.Transaction?> getTransactionData(String id) async {
    try {
      final snapshot = await firestorePath.doc(id).get();
      final data = snapshot.data()!;
      return model.Transaction.fromMap(id, data);
    } catch (e) {
      return null;
    }
  }
}
