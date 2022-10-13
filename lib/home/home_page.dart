import 'package:financial_app/home/home_content_page.dart';
import 'package:flutter/material.dart';

import '../shared/new_entry/new_entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final List<Widget> _pages = const [
    HomeContentPage(),
    Center(child: Text("Page Extrato")),
    Text(''),
    Center(child: Text('Page Estatítica')),
    Center(child: Text('Page mais')),
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
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _appBottomNavBar(),
    );
  }

  BottomNavigationBar _appBottomNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          label: 'Extrato',
        ),
        BottomNavigationBarItem(icon: SizedBox(width: 1), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_rounded),
          label: 'Estatística',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'Mais',
        ),
      ],
      currentIndex: _index,
      onTap: ((index) {
        if (index != 2) {
          setState(() {
            _index = index;
          });
        }
      }),
    );
  }
}
