import 'package:financial_app/features/profile/profile_controller.dart';
import 'package:financial_app/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/views/error_view.dart';
import '../../shared/views/loading_view.dart';
import '../home/home_content_page.dart';
import '../new_entry/new_entry_page.dart';
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
            return ErrorView(
              icon: Icons.cloud_off_rounded,
              text: state.message,
            );
          }
          if (state is SuccessDataState) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                const HomeContentPage(),
                const StatementPage(),
                const StatisticsPage(),
                BlocProvider(
                  create: (context) => ProfileController(),
                  child: const ProfilePage(),
                ),
              ],
            );
          }
          return const LoadingView();
        },
      ),
      floatingActionButton: BlocBuilder<DataController, DataState>(
        builder: (context, state) => data.state is SuccessDataState
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewEntryPage(
                        (state as SuccessDataState).categoryList,
                      ),
                    ),
                  );
                },
                tooltip: 'Nova transação',
                child: const Icon(Icons.add),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomBar(
        controller: controller,
      ),
    );
  }
}
