import 'package:flutter/material.dart';

import '../design_sys/colors.dart';
import 'app_pending.dart';

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
            color: AppColors.white,
          ),
          Container(
            height: 250,
            color: AppColors.white,
            //TODO - Seleção do mês saldo, despesa e receita
            child: const Text('Seleção do mes, saldo despesa e receita...'),
          ),
          appPending(),
          Container(
            height: 400,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
