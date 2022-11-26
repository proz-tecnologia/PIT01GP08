import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../home/components/month_changer.dart';
import 'statement_controller.dart';
import 'statement_states.dart';
import 'widgets/topbar_button.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              MonthChanger('Dezembro'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.text_snippet_rounded),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<StatementController, StatementState>(
            builder: (context, currentState) {
              if (currentState is LoadingStatementState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (currentState is ErrorStatementState) {
                return const Center(child: Text('Erro'));
              }
              final list = context.read<StatementController>().list;
              return Column(
                children: [
                  Row(
                    children: [
                      TopBarToggle.expense(),
                      TopBarToggle.income(),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.smallSpace),
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(
                              list[index].valueString,
                              style: TextStyle(
                                color: list[index].type == 'expense'
                                    ? AppColors.expense
                                    : AppColors.income,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(list[index].description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${list[index].date.day}/${list[index].date.month}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                ),
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).primaryColor,
                                  size: Sizes.smallIconSize,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
