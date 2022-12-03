import 'dart:math';

enum Type { expense, income }

enum Payment { normal, parcelled, fixed }

class Transaction {
  final DateTime date;
  final String description;
  final double value;
  final Type type;
  final int categoryId;
  final bool fulfilled;
  late final int id;
  final Payment payment;

  Transaction({
    required this.date,
    required this.description,
    required this.value,
    required this.type,
    required this.categoryId,
    required this.fulfilled,
    required this.payment,
  });

  String get valueString =>
      'R\$ ${value.toStringAsFixed(2).replaceFirst('.', ',')}';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date.toString()});
    result.addAll({'description': description});
    result.addAll({'value': value});
    result.addAll({'type': type.name});
    result.addAll({'categoryId': categoryId});
    result.addAll({'fulfilled': fulfilled});
    result.addAll({'id': id});
    result.addAll({'payment': payment.name});

    return result;
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    final random = Random();
    final type_ = random.nextBool() ? Type.expense : Type.income;
    // era pra ser map['type'] == 'expense' ? Type.expense : Type.income;
    // mas não tá vindo certo da API
    final payment_ = map['payment'] == 'normal'
        ? Payment.normal
        : map['payment'] == 'fixed'
            ? Payment.fixed
            : Payment.parcelled;

    return Transaction(
      date: DateTime.parse(map['date']),
      description: map['description'] ?? '',
      value: (map['value']?.toDouble() ?? 0.0) / 100,
      type: type_,
      categoryId: 8, //int.tryParse(map['categoryId']) ?? 0,
      fulfilled: map['fulfilled'] ?? false,
      payment: payment_,
    );
  }

  Transaction copyWith({
    DateTime? date,
    String? description,
    double? value,
    Type? type,
    int? categoryId,
    bool? fulfilled,
    Payment? payment,
  }) {
    return Transaction(
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
