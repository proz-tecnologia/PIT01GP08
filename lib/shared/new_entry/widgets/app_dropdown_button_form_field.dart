import 'package:flutter/material.dart';

class AppDropdownButtonFormField extends StatelessWidget {
  const AppDropdownButtonFormField({
    Key? key,
    required List<String> categories,
    required Color color,
  })  : _categories = categories,
        _color = color,
        super(key: key);

  final List<String> _categories;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: _color),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: _color)),
          labelText: 'Categoria',
        ),
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
