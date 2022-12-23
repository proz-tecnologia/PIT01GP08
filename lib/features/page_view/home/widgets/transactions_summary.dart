import 'package:financial_app/design_sys/sizes.dart';
import 'package:financial_app/features/page_view/home/home_controller.dart';
import 'package:financial_app/features/page_view/home/home_states.dart';
import 'package:financial_app/features/page_view/shared/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsSummary extends StatelessWidget {
  const TransactionsSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        final controller = context.read<HomeController>();
        final listTransactions = controller.displayTransactions();
        if (state is ErrorHomeState) {
          return const Center(child: Text('Erro ao carregar os dados'));
        }
        if (state is SuccessHomeState) {
          return Container(
            padding: const EdgeInsets.all(Sizes.mediumSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A vencer/vencidas',
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                listTransactions.isEmpty
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
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}