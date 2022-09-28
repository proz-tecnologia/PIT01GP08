import 'package:flutter/material.dart';

import '../design_sys/colors.dart';
import '../widgets/expandable_fab.dart';
import 'new_entry_dialog.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 30,
            color: Colors.white,
          ),
          Container(
            height: 250,
            color: Colors.white,
            //TODO - Seleção do mês saldo, despesa e receita
            child: Text('Seleção do mes, saldo despesa e receita...'),
          ),
          _appPending(),
          Container(
            height: 400,
            color: Colors.green,
          )
        ],
      ),
    );
  }

  Widget _appPending() {
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
              children: [
                Icon(
                  Icons.download,
                  size: 50,
                  color: Colors.red.shade800,
                ),
                Text('Resto a pagar'),
                Text(
                  'RS 1000,00',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red.shade800),
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
              children: [
                Icon(
                  Icons.upload,
                  size: 50,
                  color: Colors.green.shade800,
                ),
                Text('Receita a receber'),
                Text(
                  'RS 1000,00',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
