import 'package:financial_app/home/widgets/home_content_page.dart';
import 'package:flutter/material.dart';

import 'app_bottom_nav_bar.dart';
import 'new_entry/new_entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomeContentPage(),
          Center(child: Text('Page Extrato')),
          Center(child: Text('Page Estatítica')),
          Center(child: Text('Page mais')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            newEntryDialog(context, 'expense');
          });
        },
        tooltip: 'Despesa',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavBar(pageController: controller),
    );
  }
}
