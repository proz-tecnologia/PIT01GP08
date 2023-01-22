import 'package:flutter/material.dart';

import 'design_sys/themes.dart';
import 'features/pages.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/splash',
      routes: {
        '/login': (context) => const LoginPage(),
        '/splash': (context) => const SplashScreen(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const AppPageView(),
        '/new-entry': (context) => const NewEntryPage(),
        '/account-settings': (context) => const AccountPage(),
        '/settings': (context) => const SettingsPage(),
        '/my-categories': (context) => const MyCategoriesPage(),
        '/category-edit': (context) => const CategoryEditPage(),
      },
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
