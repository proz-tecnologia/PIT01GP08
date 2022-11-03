import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppFulfilledCheck extends StatefulWidget {
  AppFulfilledCheck({
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
  bool _initialFulfilled;

  @override
  State<AppFulfilledCheck> createState() => _AppFulfilledCheckState();
}

class _AppFulfilledCheckState extends State<AppFulfilledCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: widget._initialFulfilled,
          onChanged: (value) {
            setState(() {
              widget._initialFulfilled = value!;
            });
          },
          fillColor: MaterialStateProperty.all(widget._color),
        ),
        Text(widget._fulfilledLabel),
      ],
    );
  }
}
