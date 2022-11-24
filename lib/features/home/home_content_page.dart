import 'package:flutter/material.dart';

import 'widgets/app_pending.dart';
import 'components/transactions_summary.dart';
import 'widgets/resume_info_widget.dart';

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
