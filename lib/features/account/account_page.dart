import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import 'account_controller.dart';
import 'account_states.dart';
import 'widget/editable_info.dart';
import 'widget/editable_password.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final controller = AccountController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
      ),
      body: BlocListener<AccountController, AccountState>(
        bloc: controller,
        listener: (context, state) {
          if (state is ErrorAccountState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            setState(() {});
          }
          if (state is SuccessAccountState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Sucesso!")),
            );
          }
          if (state is LoggedOutAccountState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/register', (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.mediumSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Sizes.largeSpace),
                InkWell(
                  onTap: controller.updateImage,
                  child: ValueListenableBuilder(
                      valueListenable: controller.photo,
                      builder: (_, photo, __) {
                        return photo == null
                            ? Icon(
                                Icons.account_circle_rounded,
                                size: 120,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              )
                            : CircleAvatar(
                                radius: 60,
                                foregroundImage: NetworkImage(photo),
                              );
                      }),
                ),
                const SizedBox(height: Sizes.largeSpace),
                EditableInfo(
                  action: (value) => controller.updateName(value),
                  child: Text(user.displayName ?? "Usuário",
                      style: Theme.of(context).textTheme.headlineMedium),
                ),
                const SizedBox(
                  height: Sizes.largeSpace,
                  width: double.infinity,
                ),
                EditableInfo(
                  action: (value) => controller.updateEmail(value),
                  child: Text(user.email ?? "E-mail",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                ValueListenableBuilder(
                    valueListenable: controller.emailVerified,
                    builder: (_, value, __) {
                      return value
                          ? const SizedBox.shrink()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('E-mail não verificado.'),
                                TextButton(
                                  onPressed: controller.verifyEmail,
                                  child: Text(
                                    'Verificar agora',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            );
                    }),
                const SizedBox(height: Sizes.largeSpace),
                EditablePassword(
                  action: (value) => controller.updatePassword(value),
                  child: Text("Alterar senha",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                const SizedBox(height: Sizes.largeSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                              'Tem certeza que deseja excluir a sua conta?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('CANCELAR'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.deleteUser();
                                Navigator.of(context).pop();
                              },
                              child: const Text('EXCLUIR CONTA'),
                            )
                          ],
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.expense,
                          ),
                          SizedBox(width: Sizes.smallSpace),
                          Text(
                            'Excluir conta',
                            style: TextStyle(color: AppColors.expense),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
