import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
import 'profile_controller.dart';
import 'profile_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<bool> testValue = ValueNotifier(true);
  final controller = ProfileController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileController, ProfileState>(
        builder: (context, state) {
      if (state is ErrorProfileState) {
        return const Center(child: Text('Erro ao carregar os dados'));
      }
      if (state is SuccessProfileState) {
        final user = state.user;
        final listButtons = [
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(
              "/account-settings",
              arguments: state.user,
            ),
            leading: const Icon(Icons.person_rounded),
            title: const Text("Conta"),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed("/my-categories"),
            leading: const Icon(Icons.label_rounded),
            title: const Text("Categorias"),
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
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            leading: const Icon(Icons.logout_rounded),
            title: const Text("Sair do app"),
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
                  user.photoURL == null
                      ? Icon(
                          Icons.account_circle_rounded,
                          size: 120,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : CircleAvatar(
                          radius: 60,
                          foregroundImage: NetworkImage(user.photoURL!),
                        ),
                  const SizedBox(
                    height: Sizes.largeSpace,
                  ),
                  Text(user.displayName ?? "Usuário",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary)),
                ]),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.mediumSpace),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) => listButtons[index],
                  itemCount: listButtons.length,
                ),
              ),
            )
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
