import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../change_notifier.dart';

class AppDropdownButtonField extends StatelessWidget {
  const AppDropdownButtonField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => DropdownButtonFormField(
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: notifier.color),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: notifier.color)),
          labelText: 'Categoria',
        ),
        value: notifier.categories[0],
        items: notifier.categories
            .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }
}
