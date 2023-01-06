import 'package:flutter/material.dart';

class EditablePassword extends StatelessWidget {
  const EditablePassword({
    super.key,
    required this.child,
    required this.action,
  });

  final Text child;
  final Function(String value) action;

  @override
  Widget build(BuildContext context) {
    final editNotifier = ValueNotifier(false);
    final textController = TextEditingController(text: '');
    return ValueListenableBuilder(
      valueListenable: editNotifier,
      builder: (_, isEditing, __) {
        if (isEditing) {
          return TextField(
            obscureText: true,
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Nova senha'),
            onSubmitted: (value) {
              showDialog(
                context: context,
                builder: (_) {
                  final formKey = GlobalKey<FormState>();
                  return AlertDialog(
                    title: const Text('Confirme sua senha'),
                    content: Form(
                      key: formKey,
                      child: TextFormField(
                        obscureText: true,
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Digite novamente sua nova senha'),
                        validator: (value) {
                          if (textController.text != value) {
                            return 'Senha incorreta.';
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.of(context).pop();
                            action(value);
                            editNotifier.value = !editNotifier.value;
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }
        return InkWell(
          onTap: () => editNotifier.value = !editNotifier.value,
          child: child,
        );
      },
    );
  }
}
