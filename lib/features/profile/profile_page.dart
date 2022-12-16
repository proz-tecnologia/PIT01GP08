import 'package:financial_app/design_sys/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import 'profile_controller.dart';
import 'profile_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<bool> testValue = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileController, ProfileState>(
        builder: (context, state) {
      if (state is ErrorProfileState) {
        return const Center(child: Text('Erro ao carregar os dados'));
      }
      if (state is SuccessProfileState) {
        return ValueListenableBuilder(
            valueListenable: testValue,
            builder: (context, value, _) {
              final listButtons = [
                ListTile(
                  onTap: () => FirebaseAuth.instance.signOut(),
                  leading: const Icon(Icons.person_rounded),
                  title: const Text("Sair da Conta"),
                ),
                const ListTile(
                  leading: Icon(Icons.label_rounded),
                  title: Text("Categorias"),
                ),
                const ListTile(
                  leading: Icon(Icons.credit_card_rounded),
                  title: Text(" Meus Cartões"),
                ),
                const ListTile(
                  leading: Icon(Icons.account_balance_rounded),
                  title: Text("Meus Bancos"),
                ),
                const ListTile(
                  leading: Icon(Icons.account_balance_wallet_rounded),
                  title: Text("Carteira"),
                ),
                const ListTile(
                  leading: Icon(Icons.settings_rounded),
                  title: Text("Configurações"),
                ),
              ];
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(Sizes.largeSpace),
                    child: SafeArea(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const CircleAvatar(
                          radius: 60,
                          foregroundImage: NetworkImage(
                              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fstatic.pexels.com%2Fphotos%2F45201%2Fkitty-cat-kitten-pet-45201.jpeg&f=1&nofb=1&ipt=3dabf5a13a366cbddf3bbb60476af6eb3b8b4823ff7fba513c93327c8d945f7a&ipo=images"),
                        ),
                        const SizedBox(
                          height: Sizes.largeSpace,
                        ),
                        Text("Rudá Rabello",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.mediumSpace),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) => listButtons[index],
                        itemCount: listButtons.length,
                      ),
                    ),
                  )
                ],
              );
            });
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
