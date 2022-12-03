import 'package:flutter/material.dart';

class Section {
  Section(
    this.value, {
    required this.description,
    required this.color,
  });

  final double value;
  late final double percent;
  final String description;
  final Color color;
}