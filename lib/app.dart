import 'package:financial_app/shared/home_page.dart';
import 'package:financial_app/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:financial_app/design_sys/themes.dart';
import 'package:financial_app/register/register_page.dart';
import 'package:financial_app/shared/new_entry/new_entry_page.dart';

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
        '/splash-screen': (context) => SplashScreen(),
        '/register-page': (context) => const RegisterPage(),
        '/home-page': (context) => HomePage(title: 'Flutter Demo Home Page'),
        'newEntry': (context) => NewEntryPage(),
      },
      //TODO: Remover a linha 20 antes da entrega.
      //A linha seguinte foi deixada apenas para uso de testes durante o desenvolvimento.
      themeMode: ThemeMode.light,
    );
  }
}
