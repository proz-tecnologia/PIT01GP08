import 'package:flutter/material.dart';
import '../../../../design_sys/sizes.dart';
import '../statement_controller.dart';

class ExtractDialog extends StatelessWidget {
  const ExtractDialog({
    super.key,
    required this.controller,
  });

  final StatementController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          controller.displayMonth,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo anterior: '),
              Text(controller.previousBalance),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Receitas:'),
              Text(controller.income),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Despesas:'),
              Text(controller.expense),
            ],
          ),
          const SizedBox(
            height: Sizes.mediumSpace,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo parcial:'),
              Text(controller.partialBalance),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo total:'),
              Text(controller.totalBalance),
            ],
          ),
        ],
      ),
    );
  }
}
