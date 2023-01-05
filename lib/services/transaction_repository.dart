import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/transaction.dart' as model;
import '../shared/models/transaction.dart';

abstract class TransactionRepository {
  Future<bool> createTransaction(model.Transaction transaction);
  Future<model.Transaction?> getTransactionData(String id);
  Future<bool> editTransactionData(model.Transaction transaction);
  Future<bool> deleteTransaction(String id);
  Future<List<model.Transaction>> getAllTransactions();
  Future<List<model.Transaction>> getFixedTransactions();
}

class TransactionFirebaseRepository implements TransactionRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Future<bool> createTransaction(model.Transaction transaction) async {
    try {
      if (transaction.payment == Payment.fixa) {
        final map = transaction.toMap();
        final List<bool> fulfilledList = [transaction.fulfilled];
        DateTime endDate = transaction.endDate ?? DateTime.now();
        DateTime newDate = transaction.date;
        do {
          try {
            newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
          } catch (e) {
            newDate = DateTime(newDate.year + 1, 1, newDate.day);
          }
          if (!newDate.isAfter(endDate)) {
            fulfilledList.add(false);
          } else {
            break;
          }
        } while (true);
        map.update('fulfilled', (value) => fulfilledList);
        firestorePath.collection('fixed-transactions').add(map);
      } else if (transaction.payment == Payment.parcelada) {
        firestorePath
            .collection('parcelled-transactions')
            .add(transaction.toMap());
      } else {
        firestorePath.collection('transactions').add(transaction.toMap());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTransaction(String id) async {
    try {
      firestorePath.collection('transactions').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> editTransactionData(model.Transaction transaction) async {
    try {
      firestorePath
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<model.Transaction>> getAllTransactions() async {
    final list = <model.Transaction>[];
    try {
      final snapshot = await firestorePath
          .collection('transactions')
          .orderBy("date", descending: true)
          .get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        list.add(
          model.Transaction.fromMap(doc.id, doc.data()),
        );
      }
      final fixed = await getFixedTransactions();
      list.addAll(fixed);
      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));
      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<model.Transaction?> getTransactionData(String id) async {
    try {
      final snapshot =
          await firestorePath.collection('transactions').doc(id).get();
      final data = snapshot.data()!;
      return model.Transaction.fromMap(id, data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<model.Transaction>> getFixedTransactions() async {
    final list = <model.Transaction>[];
    try {
      final snapshot =
          await firestorePath.collection('fixed-transactions').get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        Map<String, dynamic> data = doc.data();
        DateTime endDate = (data['endDate'] as Timestamp).toDate();
        DateTime newDate = (data['date'] as Timestamp).toDate();
        int i = 0;
        do {
          data.update(
              'fulfilled', (value) => doc.data()['fulfilled'][i++] ?? false);
          list.add(
            model.Transaction.fromMap(doc.id, data),
          );
          try {
            newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
          } catch (e) {
            newDate = DateTime(newDate.year + 1, 1, newDate.day);
          }
          data.update('date', (_) => Timestamp.fromDate(newDate));
        } while (!newDate.isAfter(endDate));
      }
      return list;
    } catch (e) {
      return [];
    }
  }
}
