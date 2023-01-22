import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_repository.dart';
import '../../shared/widgets/logo_app.dart';
import '../../shared/widgets/social_auth_button.dart';
import 'register_controller.dart';
import 'register_states.dart';
import '../../design_sys/sizes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  RegisterController controller = RegisterController(
    CategoryFirebaseRepository(
      FirebaseFirestore.instance,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    ),
  );

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
                children: [
                  const Padding(
                    padding: EdgeInsets.all(Sizes.mediumSpace),
                    child: LogoApp(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.mediumSpace),
                    child: Text(
                      'Cadastre-se',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                    controller: nameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: emailController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Campo obrigatório';
                      } else if (!value!.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return TextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Campo obrigatório';
                          } else if (value!.length < 6) {
                            return 'Senha inválida, mínimo 6 caracteres';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Crie sua senha',
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
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Por favor, confirme sua senha';
                      } else if (value != passwordController.text) {
                        return 'As senhas estão diferentes';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Confirme sua senha',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocListener<RegisterController, RegisterState>(
                      bloc: controller,
                      listener: (context, state) {
                        if (state is LoadingRegisterState) {
                          showDialog(
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is ErrorRegisterState) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                            ),
                          );
                        }
                        if (state is SuccessRegisterState) {
                          final user = FirebaseAuth.instance.currentUser!;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Bem vindo, ${user.displayName}'),
                            ),
                          );
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Sizes.mediumSpace),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await controller.registerUser(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child: const Text('CRIAR CONTA'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SocialAuthButton(
                        onPressed: () async {
                          await controller.googleSignUp();
                        },
                        asset: 'assets/google_logo.png',
                        text: 'Cadastrar com Google'),
                  ),
                  const SizedBox(height: Sizes.mediumSpace),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text('JÁ POSSUI CADASTRO?'),
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
