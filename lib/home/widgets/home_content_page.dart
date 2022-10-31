import 'package:flutter/material.dart';

import 'app_pending.dart';
import 'transactions_summary.dart';
import 'resume_info_widget.dart';

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
        children: const [
          ResumeInfoWidget(),
          AppPending(),
          TransactionsSummary(),
        ],
      ),
    );
  }
}
