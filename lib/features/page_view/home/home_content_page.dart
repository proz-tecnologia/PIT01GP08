import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_controller.dart';
import '../data_states.dart';
import 'home_controller.dart';
import 'widgets/app_pending.dart';
import 'widgets/transactions_summary.dart';
import 'widgets/resume_info_widget.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionList =
        (context.read<DataController>().state as SuccessDataState)
            .transactionList;
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => HomeController(transactionList),
        child: Column(
          children: const [
            ResumeInfoWidget(),
            AppPending(),
            TransactionsSummary(),
          ],
        ),
      ),
    );
  }
}
