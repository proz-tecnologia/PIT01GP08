import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../design_sys/sizes.dart';
import '../../widgets/transaction_tile.dart';
import '../home_controller.dart';
import '../home_states.dart';

class TransactionsSummary extends StatelessWidget {
  const TransactionsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        final controller = context.read<HomeController>();
        final listTransactions = controller.displayTransactions();
        return Container(
          padding: const EdgeInsets.all(Sizes.mediumSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A vencer/vencidas',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              ),
              ValueListenableBuilder(
                valueListenable: context.read<HomeController>().isVisible,
                builder: (_, isVisible, __) {
                  if (!context.read<HomeController>().isVisible.value) {
                    return const SizedBox(width: double.infinity);
                  }
                  if (state is SuccessHomeState) {
                    return listTransactions.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(Sizes.largeSpace),
                            child: Text(
                              'Você ainda não possui nenhuma despesa\nfutura ou pendente!',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                TransactionTile.alert(listTransactions[index]),
                            itemCount: listTransactions.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          );
                  }
                  return const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: LinearProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
