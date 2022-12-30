import 'package:financial_app/features/account/account_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import 'account_controller.dart';
import 'widget/editable_info.dart';
import 'widget/editable_password.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AccountController();
    return BlocConsumer<AccountController, AccountState>(
      bloc: controller,
      listener: (context, state) {
        if (state is ErrorAccountState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Erro ao fazer a atualização!")));
        }
        if (state is SuccessAccountState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Sucesso!")));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //controller.user.photoURL == null
            // ?
            Icon(
              Icons.account_circle_rounded,
              size: 120,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            //       : CircleAvatar(
            //           radius: 60,
            //           foregroundImage: NetworkImage(user.photoURL!),
            //         ),
            //
            EditableInfo(
              action: (value) {
                FirebaseAuth.instance.currentUser?.updateDisplayName(value);
              },
              child: Text(
                  state is SuccessAccountState
                      ? state.user.displayName ?? "Usuário"
                      : "Usuário",
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            const SizedBox(
              height: Sizes.largeSpace,
              width: double.infinity,
            ),
            EditableInfo(
              action: (value) {
                FirebaseAuth.instance.currentUser?.updateEmail(value);
              },
              child: Text(
                  state is SuccessAccountState
                      ? state.user.email ?? "E-mail"
                      : "Email",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(
              height: Sizes.largeSpace,
            ),
            EditablePassword(
              action: (value) {
                FirebaseAuth.instance.currentUser?.updatePassword(value);
              },
              child: Text("Altere sua Senha",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(
              height: Sizes.largeSpace,
            ),
            EditableInfo(
              action: (value) {},
              child: Text(
                  state is SuccessAccountState
                      ? state.user.phoneNumber ?? "Telefone"
                      : "Telefone",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ],
        ),
      ),
    );
  }
}
