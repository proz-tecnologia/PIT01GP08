import 'package:flutter/material.dart';
import 'package:financial_app/design_sys/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/module/data_controller.dart';
import 'features/module/home_page.dart';
import 'features/login/login_controller.dart';
import 'features/login/login_page.dart';
import 'features/new_entry/new_entry_controller.dart';
import 'features/new_entry/new_entry_page.dart';
import 'features/register/register_controller.dart';
import 'features/register/register_page.dart';
import 'features/splash/splash.dart';
import 'shared/category_repository.dart';
import 'shared/transaction_repository.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash-screen',
      routes: {
        '/login': (context) => BlocProvider(
              create: (_) => LoginController(),
              child: const LoginPage(),
            ),
        '/splash-screen': (context) => const SplashScreen(),
        '/register-page': (context) => BlocProvider(
              create: (context) => RegisterController(),
              child: const RegisterPage(),
            ),
        '/home-page': (context) => BlocProvider(
              create: (context) => DataController(
                transactionRepo: TransactionFirebaseRepository(),
                categoryRepo: CategoryFirebaseRepository(),
              ),
              child: const HomePage(),
            ),
        '/new-entry': (context) => BlocProvider(
              create: (context) => NewEntryController(),
              child: const NewEntryPage(),
            ),
      },
    );
  }
}
