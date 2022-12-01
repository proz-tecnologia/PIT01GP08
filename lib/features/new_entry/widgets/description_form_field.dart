import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class DescriptionFormField extends StatelessWidget {
  const DescriptionFormField({
    Key? key,
    required this.color,
    required this.textController,
  }) : super(key: key);

  final Color color;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: color),
        labelStyle: TextStyle(color: color.withOpacity(0.6)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: color)),
        labelText: 'Descrição',
      ),
      cursorColor: AppColors.lightGrey,
    );
  }
}
