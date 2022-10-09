import 'package:financial_app/design_sys/colors.dart';
import 'package:financial_app/design_sys/light_theme.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';

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
      //TODO: define dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.black,
      ),
      themeMode: ThemeMode.light,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
