import 'package:flutter/material.dart';

class AppDropdownButtonField extends StatelessWidget {
  const AppDropdownButtonField({
    Key? key,
    required Color color,
    required List<String> categories,
  })  : _color = color,
        _categories = categories,
        super(key: key);

  final Color _color;
  final List<String> _categories;

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
      onChanged: (value) {},
    );
  }
}
