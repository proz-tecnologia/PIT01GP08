import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../design_sys/colors.dart';
import '../widgets/expandable_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(),
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
                newExpense();
              });
            },
            tooltip: 'Despesa',
            backgroundColor: AppColors.expense,
            child: const Icon(Icons.arrow_downward),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                newExpense();
              });
            },
            tooltip: 'Entrada',
            backgroundColor: AppColors.income,
            child: const Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }

  newIncome() {}
  newExpense() {}
}

