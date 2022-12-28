import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_entry_controller.dart';
import '../new_entry_states.dart';

class DescriptionFormField extends StatelessWidget {
  const DescriptionFormField(
    this.textController, {
    super.key,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
      builder: (context, state) {
        return TextFormField(
          controller: textController,
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: state.color),
            labelStyle: TextStyle(color: state.color.withOpacity(0.6)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: state.color)),
            labelText: 'Descrição',
          ),
          cursorColor: Theme.of(context).dividerColor,
        );
      },
    );
  }
}
