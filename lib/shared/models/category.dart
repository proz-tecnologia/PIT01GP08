import 'package:flutter/material.dart';

enum Type { expense, income }

class Category {
  final Color color;
  final String? id;
  final String name;
  final Type type;
  final IconData icon;

  Category({
    this.id,
    required this.color,
    required this.name,
    required this.type,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'color': color.value});
    result.addAll({'name': name});
    result.addAll({'type': type.name});
    result.addAll({'icon': icon.codePoint});

    return result;
  }

  factory Category.fromMap(String id, Map<String, dynamic> map) {
    final type_ = map['type'] == 'expense' ? Type.expense : Type.income;

    return Category(
      color: Color(map['color']),
      id: id,
      name: map['name'] ?? '',
      type: type_,
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  Category copyWith({
    Color? color,
    String? name,
    Type? type,
    IconData? icon,
  }) {
    return Category(
      color: color ?? this.color,
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
    );
  }
}
