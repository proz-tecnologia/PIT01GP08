import 'package:flutter/material.dart';

class AppFulfilledCheck extends StatefulWidget {
  const AppFulfilledCheck({
    Key? key,
    required Color color,
    required String fulfilledLabel,
    required bool initialFulfilled,
  })  : _color = color,
        _fulfilledLabel = fulfilledLabel,
        _initialFulfilled = initialFulfilled,
        super(key: key);

  final Color _color;
  final String _fulfilledLabel;
  final bool _initialFulfilled;

  @override
  State<AppFulfilledCheck> createState() => _AppFulfilledCheckState();
}

class _AppFulfilledCheckState extends State<AppFulfilledCheck> {
  bool isFulfilled = true;
  @override
  Widget build(BuildContext context) {
    isFulfilled = widget._initialFulfilled;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isFulfilled,
          onChanged: (value) {
            setState(() {
              isFulfilled = value!;
            });
          },
          fillColor: MaterialStateProperty.all(widget._color),
        ),
        Text(widget._fulfilledLabel),
      ],
    );
  }
}
