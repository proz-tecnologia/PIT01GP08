import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_content_page.dart';
import '../statement/statement_controller.dart';
import '../statement/statement_page.dart';
import '../statistics/statistics_controller.dart';
import '../statistics/statistics_page.dart';
import 'data_controller.dart';
import 'data_states.dart';
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
    final data = context.read<DataController>();
    return Scaffold(
      body: BlocBuilder<DataController, DataState>(
        builder: (context, state) {
          if (state is ErrorDataState) {
            return const Center(
              child: Text('Erro'),
            );
          }
          if (state is SuccessDataState) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                const HomeContentPage(),
                BlocProvider(
                  create: (_) => StatementController(data),
                  child: const StatementPage(),
                ),
                BlocProvider(
                  create: (_) => StatisticsController(data),
                  child: const StatisticsPage(),
                ),
                const Center(child: Text('Page mais')),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
