import 'package:financial_app/design_sys/themes.dart';
import 'package:financial_app/shared/new_entry/new_entry_page.dart';
import 'package:flutter/material.dart';

import 'shared/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        'newEntry': (context) => NewEntryPage(),
      },
      //TODO: Remover a linha 20 antes da entrega.
      //A linha seguinte foi deixada apenas para uso de testes durante o desenvolvimento.
      themeMode: ThemeMode.light,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
