import 'package:financial_app/shared/new_entry/entry_types.dart';
import 'package:flutter/material.dart';

class AppFulfilledCheck extends StatelessWidget {
  const AppFulfilledCheck({
    Key? key,
    required ValueNotifier<EntryType> typeNotifier,
    required ValueNotifier<bool> checkboxNotifier,
    required ValueNotifier<String> labelNotifier,
  })  : _typeNotifier = typeNotifier,
        _checkboxNotifier = checkboxNotifier,
        _labelNotifier = labelNotifier,
        super(key: key);

  final ValueNotifier<EntryType> _typeNotifier;
  final ValueNotifier<String> _labelNotifier;
  final ValueNotifier<bool> _checkboxNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typeNotifier,
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _checkboxNotifier,
            builder: (context, child) {
              final color = _typeNotifier.value.color;
              return Checkbox(
                value: _checkboxNotifier.value,
                onChanged: (value) {
                  _checkboxNotifier.value = value!;
                },
                fillColor: MaterialStateProperty.all(color),
              );
            },
          ),
          AnimatedBuilder(
            animation: _labelNotifier,
            builder: (context, child) => Text(_labelNotifier.value),
          ),
        ],
      ),
    );
  }
}
