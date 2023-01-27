import 'package:flutter/material.dart';

import '../my_pix_keys_controller.dart';

class PixKeyFormDialog extends StatelessWidget {
  const PixKeyFormDialog({
    super.key,
    required this.formKey,
    this.initialDescription = '',
    this.initialPixKey = '',
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final String initialDescription;
  final String initialPixKey;
  final MyPixKeysController controller;

  @override
  Widget build(BuildContext context) {
    final description = TextEditingController(text: initialDescription);
    final pixKey = TextEditingController(text: initialPixKey);
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: description,
              decoration: const InputDecoration(label: Text('Descrição')),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: pixKey,
              decoration: const InputDecoration(label: Text('Chave')),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          onPressed: () {
            controller.saveKey(
              description.text,
              pixKey: pixKey.text,
              oldDescription: initialDescription,
            );
            Navigator.of(context).pop();
          },
          child: const Text('SALVAR'),
        ),
      ],
    );
  }
}
