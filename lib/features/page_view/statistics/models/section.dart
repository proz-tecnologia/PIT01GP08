import 'package:flutter/material.dart';

class Section {
  Section(
    this.value, {
    required this.description,
    required this.color,
    required this.icon,
  });

  final double value;
  late final double percent;
  final String description;
  final Color color;
  final IconData icon;
}
