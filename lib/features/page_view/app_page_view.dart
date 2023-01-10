import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_repository.dart';
import '../../services/transaction_repository.dart';
import '../../shared/views/error_view.dart';
import '../../shared/views/loading_view.dart';
import 'home/home_content_page.dart';
import 'profile/profile_page.dart';
import 'statement/statement_page.dart';
import 'statistics/statistics_page.dart';
import 'data_controller.dart';
import 'data_states.dart';
import 'widgets/bottom_bar.dart';

class AppPageView extends StatefulWidget {
  const AppPageView({super.key});

  @override
  State<AppPageView> createState() => _AppPageViewState();
}

class _AppPageViewState extends State<AppPageView> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataController(
        transactionRepo: TransactionFirebaseRepository(),
        categoryRepo: CategoryFirebaseRepository(),
      ),
      child: Scaffold(
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
                children: const [
                  HomeContentPage(),
                  StatementPage(),
                  StatisticsPage(),
                  ProfilePage(),
                ],
              );
            }
            return const LoadingView();
          },
        ),
        floatingActionButton: BlocBuilder<DataController, DataState>(
          builder: (context, state) => state is SuccessDataState
              ? FloatingActionButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    '/new-entry',
                    arguments: state.categoryList,
                  ),
                  tooltip: 'Nova transação',
                  child: const Icon(Icons.add),
                )
              : const SizedBox.shrink(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomBar(controller: controller),
      ),
    );
  }
}
