import 'package:flutter/material.dart';
import 'package:financial_app/design_sys/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/account/account_page.dart';
import 'features/module/data_controller.dart';
import 'features/module/home_page.dart';
import 'features/login/login_controller.dart';
import 'features/login/login_page.dart';
import 'features/new_entry/new_entry_page.dart';
import 'features/register/register_controller.dart';
import 'features/register/register_page.dart';
import 'features/splash/splash.dart';
import 'shared/repositories/category_repository.dart';
import 'shared/repositories/transaction_repository.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash-screen', //TODO retirar nomes compostos das rotas
      routes: {
        '/login': (context) => BlocProvider(
              create: (_) => LoginController(),
              child: const LoginPage(),
            ),
        '/splash-screen': (context) => const SplashScreen(),
        '/register-page': (context) => const RegisterPage(),
        '/home-page': (context) => BlocProvider(
              create: (context) => DataController(
                transactionRepo: TransactionFirebaseRepository(),
                categoryRepo: CategoryFirebaseRepository(),
              ),
              child: const HomePage(),
            ),
        '/account-settings': (context) => const AccountPage(),
      },
    );
  }
}
