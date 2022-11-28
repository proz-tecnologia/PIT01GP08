enum Type { expense, income }

class Transaction {
  final DateTime _date;
  final String _description;
  final double _value;
  final Type _type;

  Transaction({
    required DateTime date,
    required String description,
    required double value,
    required Type type,
  })  : _date = date,
        _description = description,
        _value = value,
        _type = type;

  DateTime get date => _date;
  String get description => _description;
  double get value => _value;
  String get valueString =>
      'R\$ ${_value.toStringAsFixed(2).replaceFirst('.', ',')}';
  String get type => _type.name;
}
