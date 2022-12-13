import 'package:flutter/material.dart';

enum Type { expense, income }

class Category {
  final Color color;
  final String? id;
  final String name;
  final Type type;

  Category({
    this.id,
    required this.color,
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

  factory Category.fromMap(String id, Map<String, dynamic> map) {
    final type_ = map['type'] == 'expense' ? Type.expense : Type.income;

    return Category(
      color: Color(map['color']),
      id: id,
      name: map['name'] ?? '',
      type: type_,
    );
  }

  Category copyWith({
    Color? color,
    String? name,
    Type? type,
  }) {
    return Category(
      color: color ?? this.color,
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}
