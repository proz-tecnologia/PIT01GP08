import 'package:financial_app/features/register/models/user.dart';
import 'package:financial_app/features/register/register_controller.dart';
import 'package:financial_app/features/register/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> _isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final double sizeSpaceTitleTop = sizeHeight * 0.22;
    final double sizeSpaceItem = sizeHeight * 0.01;
    final double sizeButton = sizeHeight * 0.072;
    final double sizeSpaceItemButton = sizeHeight * 0.055;
    final double sizeSpaceItemEnd = sizeHeight * 0.08;

    RegisterController controller = context.read<RegisterController>();

    final navigator = Navigator.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.largeSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: sizeSpaceTitleTop,
              ),
              Text(
                'Cadastre-se',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      controller: nameController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      controller: emailController,
                      validator: (value) {
                        if ((value?.isEmpty ?? true)) {
                          return 'Email é obrigatório';
                        } else if (!value!.contains('@')) {
                          return 'Email inválido';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    ValueListenableBuilder(
                      builder: (context, value, _) {
                        return TextFormField(
                          style: const TextStyle(fontSize: Sizes.mediumSpace),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Senha é obrigatório';
                            } else if (value!.length < 6) {
                              return 'Senha inválida, mínimo 6 caracteres';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  _isVisible.value = !_isVisible.value,
                              icon: Icon(value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: value ? false : true,
                          obscuringCharacter: '*',
                        );
                      },
                      valueListenable: _isVisible,
                    ),
                    SizedBox(
                      height: sizeSpaceItemButton,
                    ),
                    SizedBox(
                      height: sizeButton,
                      width: double.infinity,
                      child: BlocListener<RegisterController, RegisterState>(
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Ops, algo deu errado'),
                                  content: Center(
                                    heightFactor: Sizes.dialogFactor,
                                    child: Text(state.error),
                                  ),
                                );
                              },
                            );
                          }

                          if (state is SuccessRegisterState) {
                            navigator.pushReplacementNamed('/home-page');
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await controller.registerUser(User(
                                  name: nameController.text,
                                  email: emailController.text,
                                  passworld: passwordController.text));
                            }
                          },
                          child: const Text('CRIAR CONTA'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeSpaceItemEnd,
              ),
              TextButton(
                onPressed: () {
                  navigator.pushNamed('/login');
                },
                child: const Text('JÁ POSSUI CADASTRO?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
