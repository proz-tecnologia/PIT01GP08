import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

enum Payment { normal, parcelada, fixa }

class Transaction {
  final DateTime date;
  final String description;
  final double value;
  final Type type;
  final String categoryId;
  bool _fulfilled;
  final String? id;
  final Payment payment;
  final DateTime? endDate;
  final int? parts;

  Transaction({
    this.id,
    required this.date,
    required this.description,
    required this.value,
    required this.type,
    required this.categoryId,
    required bool fulfilled,
    required this.payment,
    this.endDate,
    this.parts,
  })  : _fulfilled = fulfilled,
        assert(payment != Payment.fixa || endDate != null),
        assert(payment != Payment.parcelada || parts != null);

  factory Transaction.fromCategory({
    required DateTime date,
    required String description,
    required double value,
    required Category category,
    required bool fulfilled,
    required Payment payment,
    DateTime? endDate,
    int? parts,
  }) {
    return Transaction(
      date: date,
      description: description,
      value: value,
      type: category.type,
      categoryId: category.id!,
      fulfilled: fulfilled,
      payment: payment,
      endDate: endDate,
      parts: parts,
    );
  }

  String get valueString =>
      'R\$ ${value.toStringAsFixed(2).replaceFirst('.', ',')}';

  bool get fulfilled => _fulfilled;
  void fulfill() => _fulfilled = true;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': Timestamp.fromDate(date)});
    result.addAll({'description': description});
    result.addAll({'value': value});
    result.addAll({'type': type.name});
    result.addAll({'categoryId': categoryId});
    result.addAll({'fulfilled': _fulfilled});
    result.addAll({'payment': payment.name});
    if (endDate != null) {
      result.addAll({'endDate': Timestamp.fromDate(endDate!)});
    }
    if (parts != null) {
      result.addAll({'parts': parts});
    }

    return result;
  }

  factory Transaction.fromMap(String id, Map<String, dynamic> map) {
    final type = map['type'] == 'expense' ? Type.expense : Type.income;
    final payment = map['payment'] == 'normal'
        ? Payment.normal
        : map['payment'] == 'fixa'
            ? Payment.fixa
            : Payment.parcelada;

    DateTime? endDate;
    try {
      endDate = (map['endDate'] as Timestamp).toDate();
    } catch (e) {
      endDate = null;
    }

    return Transaction(
      id: id,
      date: (map['date'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      value: (map['value'] ?? 0).toDouble(),
      type: type,
      categoryId: map['categoryId'] ?? '',
      fulfilled: map['fulfilled'] ?? false,
      payment: payment,
      endDate: endDate,
      parts: map['parts'],
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
    DateTime? endDate,
    int? parts,
  }) {
    return Transaction(
      id: id,
      date: date ?? this.date,
      description: description ?? this.description,
      value: value ?? this.value * 100,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      fulfilled: fulfilled ?? _fulfilled,
      payment: payment ?? this.payment,
      endDate: endDate ?? this.endDate,
      parts: parts ?? this.parts,
    );
  }
}
