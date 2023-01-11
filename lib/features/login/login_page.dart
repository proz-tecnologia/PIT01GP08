import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart';
import '../../design_sys/sizes.dart';
import '../../shared/widgets/logo_app.dart';
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
  final isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
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
                      );
                    },
                    valueListenable: isVisible,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: Sizes.largeSpace),
                        child: TextButton(
                            onPressed: () async {
                              final message = await controller
                                  .sendPasswordResetEmail(emailController.text);
                              if (message != null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(message),
                                  ),
                                );
                              }
                            },
                            child: const Text('Esqueci minha senha')),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<LoginController, LoginState>(
                        bloc: controller,
                        listener: (context, state) {
                          if (state is LoginStateError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                          }
                          if (state is LoginStateSuccess) {
                            Navigator.of(context).pushReplacementNamed('/home');
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
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<LoginController, LoginState>(
                        bloc: controller,
                        listener: (context, state) {
                          if (state is LoginStateError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                          }
                          if (state is LoginStateSuccess) {
                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: Sizes.extraLargeSpace),
                          child: GoogleAuthButton(
                            onPressed: () async {
                              await controller.googleSignIn();
                            },
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.mediumSpace),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
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
