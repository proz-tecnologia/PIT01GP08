import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../design_sys/sizes.dart';
import '../../../../shared/utils/currency_format.dart';
import '../home_controller.dart';
import '../home_states.dart';
import 'total_tile.dart';

class ResumeInfoWidget extends StatefulWidget {
  const ResumeInfoWidget({super.key});

  @override
  State<ResumeInfoWidget> createState() => _ResumeInfoWidgetState();
}

class _ResumeInfoWidgetState extends State<ResumeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final spaceBetween = height * Sizes.threePercent;
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      margin: EdgeInsets.only(bottom: spaceBetween),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: BlocBuilder<HomeController, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Sizes.mediumSpace),
                  child: Row(
                    children: [
                      Text(
                        "Olá, ${user.displayName}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      Text(
                        DateFormat('dd/MM').format(DateTime.now()),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Saldo',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                        state is SuccessHomeState
                            ? ValueListenableBuilder(
                                valueListenable:
                                    context.read<HomeController>().isVisible,
                                builder: (_, isVisible, __) {
                                  return Text(
                                    isVisible
                                        ? state.balance.toBrReal
                                        : 'R\$ -------',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.w600),
                                  );
                                })
                            : Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: SizedBox(
                                  width: Sizes.extraLargeIconSize,
                                  child: LinearProgressIndicator(
                                    minHeight: Sizes.smallSpace,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.2),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: ValueListenableBuilder(
                        valueListenable:
                            context.read<HomeController>().isVisible,
                        builder: (context, value, _) {
                          return IconButton(
                            onPressed: () => context
                                .read<HomeController>()
                                .isVisible
                                .value = !value,
                            icon: Icon(
                              value ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spaceBetween),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TotalTile(
                      icon: Icons.arrow_downward,
                      label: 'Despesas',
                      value: state is SuccessHomeState ? state.expense : null,
                    ),
                    TotalTile(
                      icon: Icons.arrow_upward,
                      label: 'Receitas',
                      value: state is SuccessHomeState ? state.income : null,
                    ),
                  ],
                ),
                SizedBox(height: spaceBetween),
              ],
            );
          },
        ),
      ),
    );
  }
}
