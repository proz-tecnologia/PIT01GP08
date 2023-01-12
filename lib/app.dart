import 'package:flutter/material.dart';

import 'design_sys/themes.dart';
import 'features/page_view/settings/settings_page.dart';
import 'features/pages.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final data = MediaQuery.of(context);
        final window = WidgetsBinding.instance.window;
        double factor =
            window.physicalSize.shortestSide / window.devicePixelRatio / 320;
        factor = factor < 1 // works for very small screens (ex: Galaxy Pocket)
            ? 1
            : window.devicePixelRatio > 2 && factor > 2 // works for large screens (ex: iPad Air)
                ? 1.2
                : factor;
        return MediaQuery(
          data: data.copyWith(textScaleFactor: factor),
          child: child ?? const SplashScreen(),
        );
      },
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
    );
  }
}
