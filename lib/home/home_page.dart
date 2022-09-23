import 'package:flutter/material.dart';

import '../design_sys/colors.dart';
import '../widgets/expandable_fab.dart';
import 'new_entry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: componentizar clickable cards
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                newEntryDialog(context,'expense');
              });
            },
            tooltip: 'Despesa',
            backgroundColor: AppColors.expense,
            child: const Icon(Icons.arrow_downward),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                newEntryDialog(context,'income');
              });
            },
            tooltip: 'Entrada',
            backgroundColor: AppColors.income,
            child: const Icon(Icons.arrow_upward),
          ),
        ],
      ),
      bottomNavigationBar: appBottomNavBar(),
    );
  }

  BottomNavigationBar appBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Extrato',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_rounded),
          label: 'Estatísticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_rounded),
          label: 'Notificações',
        ),
      ],
      currentIndex: _index,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.splashDark,
      onTap: (index) {
        setState(() {
          _index = index;
          //TODO: implement navigation
        });
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
