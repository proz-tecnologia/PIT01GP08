import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../change_notifier.dart';

class AppFulfilledCheck extends StatelessWidget {
  const AppFulfilledCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewEntryChangeNotifier>(
      builder: (context, notifier, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: notifier.initialFulfilled,
            onChanged: (value) {
              if (notifier.initialFulfilled == true) {
                notifier.uncheckFulfilled();
              } else {
                notifier.checkFulfilled();
              }
            },
            fillColor: MaterialStateProperty.all(notifier.color),
          ),
          Text(notifier.fulfilledLabel),
        ],
      ),
    );
  }
}
