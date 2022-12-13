import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/category_repository.dart';
import '../../shared/transaction_repository.dart';
import '../statement/statement_controller.dart';
import '../statement/statement_page.dart';
import '../statistics/statistics_controller.dart';
import 'home_content_page.dart';
import '../statistics/statistics_page.dart';
import 'widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          const HomeContentPage(),
          BlocProvider(
            create: (_) => StatementController(),
            child: const StatementPage(),
          ),
          BlocProvider(
            create: (_) => StatisticsController(
              CategoryFirebaseRepository(),
              TransactionFirebaseRepository(),
            ),
            child: const StatisticsPage(),
          ),
          const Center(child: Text('Page mais')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/new-entry'),
        tooltip: 'Despesa',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(
        controller: controller,
      ),
    );
  }
}
