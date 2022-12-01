import 'package:flutter/material.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField({
    Key? key,
    required this.color,
    required this.categories,
    required this.controller,
  }) : super(key: key);

  final Color color;
  final List<String> categories;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
      onChanged: (value) {
        controller.text = value!;
      },
    );
  }
}

