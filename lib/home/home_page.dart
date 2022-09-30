import 'package:financial_app/home/home_content_page.dart';
import 'package:flutter/material.dart';

import '../design_sys/colors.dart';
import 'new_entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final List<Widget> _pages = [
    const HomeContentPage(),
    const Center(child: Text("Page Extrato")),
    const Center(child: Text('Page Estatítica')),
    const Center(child: Text('Page mais')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            newEntryDialog(context, 'expense');
          });
        },
        tooltip: 'Despesa',
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _appBottomNavBar(),
    );
  }

  BottomAppBar _appBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.blue,
      notchMargin: 5,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 0;
                  });
                },
                icon: const Icon(Icons.home_rounded),
                tooltip: 'Início',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 1;
                  });
                },
                icon: const Icon(Icons.library_books_outlined),
                tooltip: 'Extrato',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 2;
                  });
                },
                icon: const Icon(Icons.leaderboard_rounded),
                tooltip: 'Estatística',
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _index = 3;
                  });
                },
                icon: const Icon(Icons.more_horiz),
                tooltip: 'Mais',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
