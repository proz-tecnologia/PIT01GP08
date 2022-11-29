import 'package:financial_app/design_sys/colors.dart';
import 'package:financial_app/features/login/login_controller.dart';
import 'package:financial_app/features/login/login_states.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage(BuildContext context, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    backgroundColor: AppColors.primary,
  );

  bool _isVisible = false;

  void updateVisibilityOfPassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 150),
              const Padding(
                padding: EdgeInsets.all(24),
                child: Image(
                  width: 100,
                  height: 100,
                  image: AssetImage('assets/logo_colors.png'),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                style: const TextStyle(fontSize: 20),
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
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(fontSize: 20),
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  suffixIcon: IconButton(
                    onPressed: () => updateVisibilityOfPassword(),
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: _isVisible ? false : true,
                obscuringCharacter: '*',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Text('Recuperar senha',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // ignore: prefer_const_constructors
                  style: style,
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    if (_formKey.currentState?.validate() ?? false) {
                      final result = await controller.login(
                        emailController.text,
                        passwordController.text,
                      );
                      if (result is LoginStateError) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Ops, algo deu errado'),
                              content: Center(
                                child: Text(result.error),
                              ),
                            );
                          },
                        );
                      }
                      if (result is LoginStateSuccess) {
                        navigator.pushReplacementNamed('/home-page');
                      }
                    }
                  },
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
