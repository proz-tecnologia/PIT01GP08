import 'package:flutter/material.dart';

enum Type { expense, income }

class Category {
  final Color color;
  final int id;
  final String name;
  final Type type;

  Category({
    required this.color,
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'color': color.value});
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'type': type.name});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    final type_ = map['type'] == 'expense' ? Type.expense : Type.income;

    return Category(
      color: Color(map['color']),
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      type: type_,
    );
  }

  Category copyWith({
    Color? color,
    int? id,
    String? name,
    Type? type,
  }) {
    return Category(
      color: color ?? this.color,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}
