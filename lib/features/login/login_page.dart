import 'package:financial_app/shared/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import 'login_controller.dart';
import 'login_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    LoginController controller = context.read<LoginController>();
    final navigator = Navigator.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.largeSpace),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(Sizes.mediumSpace),
                      child: LogoApp()),
                  TextFormField(
                    style: const TextStyle(fontSize: Sizes.mediumSpace),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email obrigatório';
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: Sizes.mediumSpace),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return TextFormField(
                        style: const TextStyle(fontSize: Sizes.mediumSpace),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Senha obrigatória';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: IconButton(
                            onPressed: () => isVisible.value = !isVisible.value,
                            icon: Icon(value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: value ? false : true,
                        obscuringCharacter: '•',
                      );
                    },
                    valueListenable: isVisible,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Sizes.mediumSpace),
                        child: Text('Recuperar senha',
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<LoginController, LoginState>(
                      listener: (context, state) {
                        final navigator = Navigator.of(context);
                        if (state is LoginStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Senha ou e-mail inválido, verifique por favor'),
                            ),
                          );
                        }
                        if (state is LoginStateSuccess) {
                          navigator.pushReplacementNamed('/home-page');
                        }
                      },
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            await controller.login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: const Text('Entrar'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.mediumSpace),
                    child: TextButton(
                      onPressed: () {
                        navigator.pushNamed('/register-page');
                      },
                      child: const Text('CADASTRAR?'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
