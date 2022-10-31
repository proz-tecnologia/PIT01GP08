import 'package:flutter/material.dart';

class MonthChanger extends StatelessWidget {
  const MonthChanger(
    this.month, {
    Key? key,
  }) : super(key: key);

  final String month;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios)),
        Text(
          month,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
