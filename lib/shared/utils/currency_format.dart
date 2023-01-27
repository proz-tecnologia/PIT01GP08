extension Currency on double {
  String get toBrReal => 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
}

extension CurrencyStr on String {
  double get fromBrReal => double.parse(
        replaceAll(RegExp('[R\$]'), '')
            .replaceAll('.', '')
            .replaceAll(',', '.'),
      );
}
