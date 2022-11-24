import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextInputAction _textInputActionNext = TextInputAction.next;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final double sizeSpaceTitleTop = sizeHeight * 0.22;
    final double sizeSpaceItem = sizeHeight * 0.01;
    final double sizeButton = sizeHeight * 0.072;
    final double sizeSpaceItemButton = sizeHeight * 0.055;
    final double sizeSpaceItemEnd = sizeHeight * 0.08;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: sizeSpaceTitleTop,
              ),
              Text(
                'Cadastre-se',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormField(
                        textInputAction: _textInputActionNext,
                        decoration: const InputDecoration(labelText: 'Nome')),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormField(
                        textInputAction: _textInputActionNext,
                        decoration: const InputDecoration(labelText: 'Email')),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Senha')),
                    SizedBox(
                      height: sizeSpaceItemButton,
                    ),
                    SizedBox(
                      height: sizeButton,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                        },
                        child: const Text('CRIAR CONTA'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeSpaceItemEnd,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('JÁ POSSUI CADASTRO?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
