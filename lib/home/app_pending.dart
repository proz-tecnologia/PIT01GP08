import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

Widget appPending() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 130,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: const [
                Icon(
                  Icons.download,
                  size: 50,
                  color: AppColors.expense,
                ),
                Text('Resto a pagar'),
                Text(
                  'RS 1000,00',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.expense),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 160,
          height: 130,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: const [
                Icon(
                  Icons.upload,
                  size: 50,
                  color: AppColors.income,
                ),
                Text('Receita a receber'),
                Text(
                  'RS 1000,00',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.income),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }