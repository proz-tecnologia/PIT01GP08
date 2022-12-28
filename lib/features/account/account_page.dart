import 'package:financial_app/features/account/account_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AccountController();
    return BlocListener<AccountController, AccountState>(
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
      child: Scaffold(
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
            Text(
                //user.displayName ??
                "Usuário",
                style: Theme.of(context).textTheme.displayLarge),
            Text(
                //user.displayName ??
                "Email",
                style: Theme.of(context).textTheme.displayLarge),
            Text(
                //user.displayName ??
                "Senha",
                style: Theme.of(context).textTheme.displayLarge),
            Text(
                //user.displayName ??
                "Telefone",
                style: Theme.of(context).textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
