import 'package:financial_app/design_sys/colors.dart';
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
      //TODO: define parameters
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: AppColors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.black,
      ),
      themeMode: ThemeMode.light,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
