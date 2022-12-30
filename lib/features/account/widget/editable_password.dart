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
    final textController = TextEditingController(text: child.data ?? '');
    return ValueListenableBuilder(
      valueListenable: editNotifier,
      builder: (_, isEditing, __) {
        if (isEditing) {
          return TextField(
            controller: textController,
            autofocus: true,
            onSubmitted: (value) {
              action(value);
              editNotifier.value = !editNotifier.value;
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
