import 'package:flutter/material.dart';

class Section {
  Section(
    double value, {
    String description = '',
    required Color color,
  })  : _value = value,
        _description = description,
        _color = color;

  final double _value;
  late double percent;
  final String _description;
  final Color _color;

  double get value => _value;
  String get description => _description;
  Color get color => _color;
}