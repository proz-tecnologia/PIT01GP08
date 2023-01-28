import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_sys/sizes.dart';
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
        final value = state.categories.contains(controller.value)
            ? controller.value
            : state.categories[0];
        controller.value = value;
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.smallSpace,
                          ),
                          child: Icon(category.icon, color: category.color),
                        ),
                        Text(category.name),
                      ],
                    ),
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
