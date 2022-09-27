import 'package:flutter/material.dart';

class AppDropdownButtonFormField extends StatelessWidget {
  const AppDropdownButtonFormField({
    Key? key,
    required List<String> categories,
  })  : _categories = categories,
        super(key: key);

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: _categories[0],
        items: _categories
            .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
            .toList(),
        onChanged: (value) {});
  }
}
