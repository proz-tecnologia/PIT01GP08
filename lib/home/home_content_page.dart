import 'package:flutter/material.dart';

import '../design_sys/colors.dart';
import 'app_pending.dart';
import 'transactions_summary.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPage();
}

class _HomeContentPage extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: AppColors.white,
              //TODO - Seleção do mês saldo, despesa e receita
              child: const Text('Seleção do mes, saldo despesa e receita...'),
            ),
            const AppPending(),
            const TransactionsSummary(),
          ],
        ),
      ),
    );
  }
}
