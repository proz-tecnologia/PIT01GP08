import 'package:dio/dio.dart';

import 'models/transaction.dart';

const transactionsUrl =
    'https://mockend.com/rudarabello/flutter_dio_challenge/transactions';

abstract class TransactionRepository {
  Future<bool> createTransaction(Transaction transaction);
  Future<Transaction?> getTransactionData(int id);
  Future<bool> editTransactionData(Transaction transaction);
  Future<bool> deleteTransaction(int id);
  Future<List<Transaction>> getAllTransactions();
}

class TransactionDioRepository implements TransactionRepository {
  final _dio = Dio();

  @override
  Future<bool> createTransaction(Transaction transaction) async {
    try {
      final response =
          await _dio.post(transactionsUrl, data: transaction.toMap());
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTransaction(int id) async {
    final response = await _dio.delete('$transactionsUrl/$id');
    return response.statusCode == 204;
  }

  @override
  Future<bool> editTransactionData(Transaction transaction) async {
    final response = await _dio.put('$transactionsUrl/${transaction.id}',
        data: transaction.toMap());
    return response.statusCode == 200;
  }

  @override
  Future<Transaction?> getTransactionData(int id) async {
    final response = await _dio.get('$transactionsUrl/$id');
    if (response.statusCode == 200) {
      return Transaction.fromMap(response.data);
    }
    return null;
  }

  @override
  Future<List<Transaction>> getAllTransactions() async {
    // final response = await _dio.get(transactionsUrl);
    // if (response.statusCode == 200) {
    //   final list = List<Transaction>.from(
    //       response.data.map((e) => Transaction.fromMap(e)));
    //   list.sort((a, b) => b.date.compareTo(a.date));
    //   return list;
    // }
    // return [];
    return [
      Transaction(
        date: DateTime.now().add(const Duration(days: 2)),
        description: 'Exemplo de despesa futura',
        value: 100.5,
        type: Type.expense,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
      Transaction(
        date: DateTime.now().add(const Duration(days: 2)),
        description: 'Exemplo de receita futura',
        value: 300.25,
        type: Type.income,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
      Transaction(
        date: DateTime.now(),
        description: 'Exemplo de despesa hoje',
        value: 200.25,
        type: Type.expense,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
      Transaction(
        date: DateTime.now(),
        description: 'Exemplo de receita hoje',
        value: 200.5,
        type: Type.income,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
      Transaction(
        date: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Exemplo de despesa passada',
        value: 300,
        type: Type.expense,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
      Transaction(
        date: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Exemplo de receita passada',
        value: 100.75,
        type: Type.income,
        categoryId: 1,
        fulfilled: true,
        payment: Payment.normal,
      ),
    ];
  }
}
