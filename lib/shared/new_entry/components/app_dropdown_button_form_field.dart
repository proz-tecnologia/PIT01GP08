import 'package:flutter/material.dart';

import '../entry_types.dart';

class AppDropdownButtonFormField extends StatelessWidget {
  const AppDropdownButtonFormField(
    ValueNotifier<EntryType> typeNotifier,{
    Key? key,
  })  : _typeNotifier = typeNotifier,
        super(key: key);

  final ValueNotifier<EntryType> _typeNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _typeNotifier,
      builder: (context, child) {
        final categories = _typeNotifier.value.categories;
        final color = _typeNotifier.value.color;
        return DropdownButtonFormField(
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(color: color),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              labelText: 'Categoria',
            ),
            value: categories[0],
            items: categories
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) {});
      },
    );
  }
}
