import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/models/category.dart';
import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField(
    this.controller, {
    super.key,
  });

  final ValueNotifier<Category?> controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        // if (!state.categories.contains(controller.value)) {
        //   controller.value = null;
        // }
        final value = state.categories.contains(controller.value)
            ? controller.value
            : state.categories[0];
        return DropdownButtonFormField(
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: state.color),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: state.color)),
            labelText: 'Categoria',
          ),
          value: value,
          items: state.categories
            .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                ))
            .toList(),
          onChanged: (value) {
            controller.value = value!;
          },
        );
      },
    );
  }
}
