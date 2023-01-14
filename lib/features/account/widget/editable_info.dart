import 'package:flutter/material.dart';

class EditableInfo extends StatelessWidget {
  const EditableInfo({
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
    Text newChild = child;
    return ValueListenableBuilder(
      valueListenable: editNotifier,
      builder: (_, isEditing, __) {
        if (isEditing) {
          return TextField(
            controller: textController,
            autofocus: true,
            onSubmitted: (value) {
              action(value);
              newChild = child.copyWithNewText(textController.text);
              editNotifier.value = !editNotifier.value;
            },
          );
        }
        return InkWell(
          onTap: () => editNotifier.value = !editNotifier.value,
          child: newChild,
        );
      },
    );
  }
}

extension on Text {
  Text copyWithNewText(String value) {
    return Text(
      value,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
