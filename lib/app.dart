import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'design_sys/themes.dart';
import 'features/account/account_page.dart';
import 'features/my_categories/category_edit_page.dart';
import 'features/my_categories/my_categories_page.dart';
import 'features/page_view/data_controller.dart';
import 'features/page_view/app_page_view.dart';
import 'features/login/login_controller.dart';
import 'features/login/login_page.dart';
import 'features/register/register_page.dart';
import 'features/splash/splash.dart';
import 'services/category_repository.dart';
import 'services/transaction_repository.dart';
import 'shared/models/category.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        '/login': (context) => BlocProvider(
              create: (_) => LoginController(),
              child: const LoginPage(),
            ),
        '/splash': (context) => const SplashScreen(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => BlocProvider(
              create: (context) => DataController(
                transactionRepo: TransactionFirebaseRepository(),
                categoryRepo: CategoryFirebaseRepository(),
              ),
              child: const AppPageView(),
            ),
        '/account-settings': (context) => const AccountPage(),
        '/my-categories': (context) => const MyCategoriesPage(),
        '/category-edit': (context) {
          final category =
              (ModalRoute.of(context)?.settings.arguments) as Category?;
          return CategoryEditPage(category: category);
        },
      },
    );
  }
}
