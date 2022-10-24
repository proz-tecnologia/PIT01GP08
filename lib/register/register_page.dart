import 'dart:io';

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
              const Text(
                'Cadastre-se',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormFieldDefault(
                        textInputAction: _textInputActionNext,
                        labelText: 'Nome'),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    TextFormFieldDefault(
                        textInputAction: _textInputActionNext,
                        labelText: 'Email'),
                    SizedBox(
                      height: sizeSpaceItem,
                    ),
                    const TextFormFieldDefault(
                        textInputAction: TextInputAction.done,
                        labelText: 'Senha'),
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
                        child: const Text(
                          'CRIAR CONTA',
                          style: TextStyle(
                            fontSize: 18,
                          ),
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
                onPressed: () {},
                child: const Text(
                  'JÁ POSSUI CADASTRO?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldDefault extends StatelessWidget {
  const TextFormFieldDefault({
    Key? key,
    required TextInputAction textInputAction,
    required String labelText,
  })  : _textInputAction = textInputAction,
        _labelText = labelText,
        super(key: key);

  final TextInputAction _textInputAction;
  final String _labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: _textInputAction,
      decoration: InputDecoration(
        labelText: _labelText,
      ),
    );
  }
}
