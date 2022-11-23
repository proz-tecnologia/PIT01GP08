import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../statistics/statistics_controller.dart';
import 'home_content_page.dart';
import '../statistics/statistics_page.dart';
import 'widgets/app_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
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
          const Center(child: Text('Page Extrato')),
          BlocProvider(
            create: (_) => StatisticsController(),
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
      bottomNavigationBar: AppBottomNavBar(pageController: controller),
    );
  }
}
