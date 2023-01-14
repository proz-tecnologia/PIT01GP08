import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/models/transaction.dart' as model;
import '../shared/models/transaction.dart';
import '../shared/utils/end_of_month.dart';

abstract class TransactionRepository {
  Future<void> createTransaction(model.Transaction transaction);
  Future<void> editTransactionData(model.Transaction transaction);
  Future<void> deleteTransaction(model.Transaction transaction);
  Future<void> fulfillTransaction(model.Transaction transaction);
  Future<List<model.Transaction>> getAllTransactions();
}

class TransactionFirebaseRepository implements TransactionRepository {
  final firestorePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('transactions');

  @override
  Future<void> createTransaction(model.Transaction transaction) async {
    try {
      if (transaction.payment == Payment.fixa) {
        final map = transaction.toMap();
        final List<bool> fulfilledList = [transaction.fulfilled];
        DateTime endDate = transaction.endDate ?? DateTime.now();
        DateTime newDate = transaction.date;
        do {
          newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
          if (!newDate.isAfter(endDate)) {
            fulfilledList.add(false);
          } else {
            break;
          }
        } while (true);
        map.update('fulfilled', (value) => fulfilledList);
        firestorePath.add(map);
      } else if (transaction.payment == Payment.parcelada) {
        final map = transaction.toMap();
        final List<bool> fulfilledList = [transaction.fulfilled];
        for (var i = 1; i < (transaction.parts ?? 0); i++) {
          fulfilledList.add(false);
        }
        map.update('fulfilled', (value) => fulfilledList);
        firestorePath.add(map);
      } else {
        firestorePath.add(transaction.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTransaction(model.Transaction transaction) async {
    try {
      firestorePath.doc(transaction.id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTransactionData(model.Transaction transaction) async {
    try {
      final map = transaction.toMap();
      if (transaction.payment != Payment.normal) {
        map.remove('fulfilled');
      }
      await firestorePath.doc(transaction.id).update(map);

      if (transaction.payment != Payment.normal) {
        try {
          // same transaction payment type
          await fulfillTransaction(transaction, fulfill: transaction.fulfilled);
        } catch (e) {
          // switching transaction payment type
          final List<bool> fulfilledList = [transaction.fulfilled];
          if (transaction.payment == Payment.fixa) {
            DateTime endDate = transaction.endDate ?? DateTime.now();
            DateTime newDate = transaction.date;
            do {
              newDate = DateTime(newDate.year, newDate.month + 1, newDate.day);
              if (!newDate.isAfter(endDate)) {
                fulfilledList.add(false);
              } else {
                break;
              }
            } while (true);
            map.update('fulfilled', (value) => fulfilledList);
          } else if (transaction.payment == Payment.parcelada) {
            for (var i = 1; i < (transaction.parts ?? 0); i++) {
              fulfilledList.add(false);
            }
          }
          await firestorePath
              .doc(transaction.id)
              .update({'fulfilled': fulfilledList});
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> fulfillTransaction(
    model.Transaction transaction, {
    bool fulfill = true,
  }) async {
    try {
      if (transaction.payment == Payment.normal) {
        await firestorePath.doc(transaction.id).update({'fulfilled': fulfill});
      } else {
        final doc = await firestorePath.doc(transaction.id).get();

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
        if (part >= list.length) {
          for (var i = list.length; i <= part; i++) {
            list.add(false);
          }
        }
        list[part] = fulfill;

        await firestorePath.doc(transaction.id).update({'fulfilled': list});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<model.Transaction>> getAllTransactions() async {
    final list = <model.Transaction>[];
    try {
      final snapshot =
          await firestorePath.orderBy('date', descending: true).get();
      final docs = snapshot.docs;

      for (var doc in docs) {
        Map<String, dynamic> data = doc.data();
        switch (data['payment']) {
          case 'fixa':
            DateTime endDate = (data['endDate'] as Timestamp).toDate();
            DateTime initialDate = (data['date'] as Timestamp).toDate();
            DateTime newDate = initialDate;
            int i = 0;
            bool isCopy = false;
            do {
              final isFulfilled = i < doc.data()['fulfilled'].length
                  ? doc.data()['fulfilled'][i++] ?? false
                  : false;
              data.update('fulfilled', (value) => isFulfilled);
              list.add(
                model.Transaction.fromMap(doc.id, data, isCopy: isCopy),
              );
              isCopy = true;
              final targetMonth = newDate.month + 1;
              newDate =
                  DateTime(newDate.year, newDate.month + 1, initialDate.day);
              if (newDate.month != targetMonth && newDate.month != 1) {
                newDate = DateTime(newDate.year, targetMonth).endOfMonth();
              }
              data.update('date', (_) => Timestamp.fromDate(newDate));
            } while (!newDate.isAfter(endDate));
            break;

          case 'parcelada':
            DateTime initialDate = (data['date'] as Timestamp).toDate();
            DateTime newDate = initialDate;
            data.update('value', (value) => value / data['parts']);
            bool isCopy = false;

            for (var i = 0; i < data['parts']; i++) {
              final isFulfilled = i < doc.data()['fulfilled'].length
                  ? doc.data()['fulfilled'][i] ?? false
                  : false;
              data.update('fulfilled', (value) => isFulfilled);
              list.add(
                model.Transaction.fromMap(doc.id, data, isCopy: isCopy),
              );
              isCopy = true;
              final targetMonth = newDate.month + 1;
              newDate =
                  DateTime(newDate.year, newDate.month + 1, initialDate.day);
              if (newDate.month != targetMonth && newDate.month != 1) {
                newDate = DateTime(newDate.year, targetMonth).endOfMonth();
              }
              data.update('date', (_) => Timestamp.fromDate(newDate));
            }
            break;

          default:
            list.add(
              model.Transaction.fromMap(doc.id, data),
            );
        }
      }

      list.sort((a, b) => b.date.millisecondsSinceEpoch
          .compareTo(a.date.millisecondsSinceEpoch));

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
