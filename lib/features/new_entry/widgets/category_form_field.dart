import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField(
    this.controller, {
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: state.color),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: state.color)),
            labelText: 'Categoria',
          ),
          value: state.categories[0].id,
          items: state.categories
              .map((category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ))
              .toList(),
          onChanged: (value) {
            controller.text = value!;
          },
        );
      },
    );
  }
}
