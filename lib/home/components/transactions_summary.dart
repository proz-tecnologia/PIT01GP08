import 'package:flutter/material.dart';

import '../../design_sys/colors.dart';

class TransactionsSummary extends StatelessWidget {
  const TransactionsSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: navigation
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            mySummary[0],
            const Divider(),
            mySummary[1],
            const Divider(),
            mySummary[2],
          ],
        ),
      ),
    );
  }
}

//Valores de exemplo
//TODO: implement class and switch widget builder to itemBuilder
const mySummary = [
  ListTile(
    title: Text(
      'R\$ 850,00',
      style: TextStyle(
        color: AppColors.expense,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text('Parcela carro'),
    trailing: Icon(
      Icons.warning_rounded,
      color: AppColors.expense,
    ),
  ),
  ListTile(
    title: Text(
      'R\$ 1450,00',
      style: TextStyle(
        color: AppColors.income,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text('Salário'),
  ),
  ListTile(
    title: Text(
      'R\$ 23,90',
      style: TextStyle(
        color: AppColors.expense,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text('Remédio'),
  ),
];
