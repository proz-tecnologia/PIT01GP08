import 'package:financial_app/features/home/home_page.dart';
import 'package:financial_app/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:financial_app/design_sys/themes.dart';

import 'features/new_entry/new_entry_page.dart';
import 'features/register/register_page.dart';
import 'features/splash/splash.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash-screen',
      routes: {
        'login': (context) => LoginPage(context),
        '/splash-screen': (context) => SplashScreen(),
        '/register-page': (context) => const RegisterPage(),
        '/home-page': (context) =>
            const HomePage(title: 'Flutter Demo Home Page'),
        '/new-entry': (context) => NewEntryPage(),
      },
      //TODO: Remover a linha 20 antes da entrega.
      //A linha seguinte foi deixada apenas para uso de testes durante o desenvolvimento.
      themeMode: ThemeMode.light,
    );
  }
}
