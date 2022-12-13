import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/transaction.dart' as model;

const transactionsUrl =
    'https://mockend.com/rudarabello/flutter_dio_challenge/transactions';

abstract class TransactionRepository {
  Future<bool> createTransaction(model.Transaction transaction);
  Future<model.Transaction?> getTransactionData(String id);
  Future<bool> editTransactionData(model.Transaction transaction);
  Future<bool> deleteTransaction(String id);
  Future<List<model.Transaction>> getAllTransactions();
}

class TransactionDioRepository implements TransactionRepository {
  final _dio = Dio();

  @override
  Future<bool> createTransaction(model.Transaction transaction) async {
    try {
      final response =
          await _dio.post(transactionsUrl, data: transaction.toMap());
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTransaction(String id) async {
    final response = await _dio.delete('$transactionsUrl/$id');
    return response.statusCode == 204;
  }

  @override
  Future<bool> editTransactionData(model.Transaction transaction) async {
    final response = await _dio.put('$transactionsUrl/${transaction.id}',
        data: transaction.toMap());
    return response.statusCode == 200;
  }

  @override
  Future<model.Transaction?> getTransactionData(String id) async {
    final response = await _dio.get('$transactionsUrl/$id');
    if (response.statusCode == 200) {
      return model.Transaction.fromMap(response.data['id'], response.data);
    }
    return null;
  }

  @override
  Future<List<model.Transaction>> getAllTransactions() async {
    final response = await _dio.get(transactionsUrl);
    if (response.statusCode == 200) {
      final list = List<model.Transaction>.from(
          response.data.map((e) => model.Transaction.fromMap(e['id'], e)));
      list.sort((a, b) => b.date.compareTo(a.date));
      return list;
    }
    return [];
  }
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
      final snapshot = await firestorePath.get();
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
