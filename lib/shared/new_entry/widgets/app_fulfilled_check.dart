import 'package:flutter/material.dart';

class AppFulfilledCheck extends StatelessWidget {
  const AppFulfilledCheck({
    Key? key,
    required checkboxNotifier,
    required labelNotifier,
    required Color color,
  })  : _checkboxNotifier = checkboxNotifier,
        _labelNotifier = labelNotifier,
        _color = color,
        super(key: key);

  final Color _color;
  final ValueNotifier<String> _labelNotifier;
  final ValueNotifier<bool> _checkboxNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _checkboxNotifier,
          builder: (context, child) => Checkbox(
            value: _checkboxNotifier.value,
            onChanged: (value) {
              _checkboxNotifier.value = value!;
            },
            fillColor: MaterialStateProperty.all(_color),
          ),
        ),
        AnimatedBuilder(
          animation: _labelNotifier,
          builder: (context, child) => Text(_labelNotifier.value),
        ),
      ],
    );
  }
}
