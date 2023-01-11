import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/transaction.dart' as model;
import '../shared/models/transaction.dart';

abstract class TransactionRepository {
  Future<void> createTransaction(model.Transaction transaction);
  Future<model.Transaction?> getTransactionData(String id);
  Future<void> editTransactionData(model.Transaction transaction);
  Future<void> deleteTransaction(String id);
  Future<List<model.Transaction>> getAllTransactions();
  Future<List<model.Transaction>> getFixedTransactions();
  Future<List<model.Transaction>> getParcelledTransactions();
  Future<void> fulfillTransaction(model.Transaction transaction);
}

class TransactionFirebaseRepository implements TransactionRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Future<void> createTransaction(model.Transaction transaction) async {
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
        final map = transaction.toMap();
        final List<bool> fulfilledList = [transaction.fulfilled];
        for (var i = 1; i < (transaction.parts ?? 0); i++) {
          fulfilledList.add(false);
        }
        map.update('fulfilled', (value) => fulfilledList);
        firestorePath.collection('parcelled-transactions').add(map);
      } else {
        firestorePath.collection('transactions').add(transaction.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      firestorePath.collection('transactions').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTransactionData(model.Transaction transaction) async {
    try {
      firestorePath
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());
    } catch (e) {
      rethrow;
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
      final parcelled = await getParcelledTransactions();
      list.addAll(parcelled);
      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));
      return list;
    } catch (e) {
      rethrow;
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
      rethrow;
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
      rethrow;
    }
  }

  @override
  Future<List<model.Transaction>> getParcelledTransactions() async {
    final list = <model.Transaction>[];
    try {
      final snapshot =
          await firestorePath.collection('parcelled-transactions').get();
      final docs = snapshot.docs;
      for (var doc in docs) {
        Map<String, dynamic> data = doc.data();
        DateTime newDate = (data['date'] as Timestamp).toDate();
        data.update('value', (value) => value / data['parts']);
        for (var i = 0; i < data['parts']; i++) {
          data.update(
              'fulfilled', (value) => doc.data()['fulfilled'][i] ?? false);
          list.add(
            model.Transaction.fromMap(doc.id, data),
          );
          try {
            newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
          } catch (e) {
            newDate = DateTime(newDate.year + 1, 1, newDate.day);
          }
          data.update('date', (_) => Timestamp.fromDate(newDate));
        }
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> fulfillTransaction(
    model.Transaction transaction, {
    fulfill = true,
  }) async {
    try {
      if (transaction.payment == Payment.normal) {
        await firestorePath
            .collection('transactions')
            .doc(transaction.id)
            .update({'fulfilled': fulfill});
      } else {
        final path = transaction.payment == Payment.fixa
            ? 'fixed-transactions'
            : 'parcelled-transactions';
        final doc =
            await firestorePath.collection(path).doc(transaction.id).get();

        DateTime newDate = ((doc.data() ?? {})['date'] as Timestamp).toDate();
        int part = 0;
        while (newDate.isBefore(transaction.date)) {
          part++;
          try {
            newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
          } catch (e) {
            newDate = DateTime(newDate.year + 1, 1, newDate.day);
          }
        }

        List list = (doc.data() ?? {})['fulfilled'];
        list[part] = fulfill;

        await firestorePath
            .collection(path)
            .doc(transaction.id)
            .update({'fulfilled': list});
      }
    } catch (e) {
      rethrow;
    }
  }
}
