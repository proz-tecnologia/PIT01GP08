import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

enum Payment { normal, parcelada, fixa }

class Transaction {
  final DateTime date;
  final String description;
  final double value;
  final Type type;
  final String categoryId;
  final bool fulfilled;
  final String? id;
  final Payment payment;

  Transaction({
    this.id,
    required this.date,
    required this.description,
    required this.value,
    required this.type,
    required this.categoryId,
    required this.fulfilled,
    required this.payment,
  });

  factory Transaction.fromCategory({
    required DateTime date,
    required String description,
    required double value,
    required Category category,
    required bool fulfilled,
    required Payment payment,
  }) {
    return Transaction(
      date: date,
      description: description,
      value: value,
      type: category.type,
      categoryId: category.id!,
      fulfilled: fulfilled,
      payment: payment,
    );
  }

  String get valueString =>
      'R\$ ${value.toStringAsFixed(2).replaceFirst('.', ',')}';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': Timestamp.fromDate(date)});
    result.addAll({'description': description});
    result.addAll({'value': value});
    result.addAll({'type': type.name});
    result.addAll({'categoryId': categoryId});
    result.addAll({'fulfilled': fulfilled});
    result.addAll({'payment': payment.name});

    return result;
  }

  factory Transaction.fromMap(String id, Map<String, dynamic> map) {
    final type_ = map['type'] == 'expense' ? Type.expense : Type.income;
    final payment_ = map['payment'] == 'normal'
        ? Payment.normal
        : map['payment'] == 'fixed'
            ? Payment.fixa
            : Payment.parcelada;

    return Transaction(
      id: id,
      date: (map['date'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      value: (map['value'] ?? 0).toDouble(),
      type: type_,
      categoryId: map['categoryId'] ?? '',
      fulfilled: map['fulfilled'] ?? false,
      payment: payment_,
    );
  }

  Transaction copyWith({
    DateTime? date,
    String? description,
    double? value,
    Type? type,
    String? categoryId,
    bool? fulfilled,
    Payment? payment,
  }) {
    return Transaction(
      id: id,
      date: date ?? this.date,
      description: description ?? this.description,
      value: value ?? this.value * 100,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      fulfilled: fulfilled ?? this.fulfilled,
      payment: payment ?? this.payment,
    );
  }
}
