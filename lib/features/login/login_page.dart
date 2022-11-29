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
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> _isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    LoginController controller = context.read<LoginController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.largeSpace),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: Sizes.largeSpace),
                const Padding(
                  padding: EdgeInsets.all(Sizes.largeSpace),
                  child: Image(
                    width: Sizes.logoSize,
                    height: Sizes.logoSize,
                    image: AssetImage('assets/logo_colors.png'),
                  ),
                ),
                const SizedBox(height: Sizes.largeSpace),
                TextFormField(
                  style: const TextStyle(fontSize: Sizes.mediumSpace),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Email obrigatório';
                    }
                    return null;
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
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        suffixIcon: IconButton(
                          onPressed: () => _isVisible.value = !_isVisible.value,
                          icon: Icon(
                              value ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      obscureText: value ? false : true,
                      obscuringCharacter: '*',
                    );
                  },
                  valueListenable: _isVisible,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: Sizes.extraLargeSpace),
                      child: Text('Recuperar senha',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.extraLargeSpace),
                SizedBox(
                  width: double.infinity,
                  child: BlocListener<LoginController, LoginState>(
                    listener: (context, state) {
                      final navigator = Navigator.of(context);
                      if (state is LoginStateError) {
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
                      if (state is LoginStateSuccess) {
                        navigator.pushReplacementNamed('/home-page');
                      }
                    },
                    child: ElevatedButton(
                      // ignore: prefer_const_constructors
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
