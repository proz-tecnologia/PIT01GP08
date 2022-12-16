import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import '../../shared/models/transaction.dart';
import '../../shared/widgets/top_bar_toggle_button.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';
import 'widgets/widgets.dart';

class NewEntryContent extends StatefulWidget {
  const NewEntryContent({super.key});

  @override
  State<NewEntryContent> createState() => _NewEntryContentState();
}

class _NewEntryContentState extends State<NewEntryContent> {
  final formKey = GlobalKey<FormState>();
  final fulfilled = ValueNotifier(true);
  final paymentOption = ValueNotifier(0);

  final value = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  final date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewEntryController, NewEntryState>(
      builder: (_, __) {
        final controller = context.read<NewEntryController>();
        final state = controller.state as NewEntryTypeState;
        final categories = state is IncomeNewEntryState
            ? controller.incomeCategories
            : controller.expenseCategories;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TopBarToggleButton.expense(
                  isSelected: state is ExpenseNewEntryState,
                  onPressed: () => controller.changeType(isIncome: false),
                ),
                TopBarToggleButton.income(
                  isSelected: state is IncomeNewEntryState,
                  onPressed: () => controller.changeType(isIncome: true),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Sizes.largeSpace),
                  child: Column(
                    children: <Widget>[
                      CurrencyFormField(
                        color: state.color,
                        textController: value,
                      ),
                      const SizedBox(height: Sizes.smallSpace),
                      DescriptionFormField(
                        color: state.color,
                        textController: description,
                      ),
                      const SizedBox(height: Sizes.smallSpace),
                      CategoryFormField(
                          color: state.color,
                          categories: categories,
                          controller: category),
                      const SizedBox(height: Sizes.mediumSpace),
                      PaymentFormField(
                        color: state.color,
                        controller: paymentOption,
                      ),
                      const SizedBox(height: Sizes.smallSpace),
                      DatePickerFormField(
                        color: state.color,
                        textController: date,
                      ),
                      const SizedBox(height: Sizes.smallSpace),
                      FulfilledFormField(
                        boolController: fulfilled,
                        color: state.color,
                        label: state.initialFulfilledLabel,
                      ),
                      const SizedBox(height: Sizes.mediumSpace),
                      Padding(
                        padding: const EdgeInsets.all(Sizes.mediumSpace),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    controller.saveTransaction(
                                      Transaction(
                                        date: DateTime(
                                          int.parse(date.text.substring(6)),
                                          int.parse(date.text.substring(3, 5)),
                                          int.parse(date.text.substring(0, 2)),
                                        ),
                                        description: description.text,
                                        value: double.parse(value.text),
                                        type: state is IncomeNewEntryState
                                            ? Type.income
                                            : Type.expense,
                                        categoryId: '1',
                                        fulfilled: fulfilled.value,
                                        payment: paymentOption.value == 0
                                            ? Payment.normal
                                            : paymentOption.value == 1
                                                ? Payment.fixed
                                                : Payment.parcelled,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('OK'),
                              ),
                            ),
                            const SizedBox(height: Sizes.mediumSpace),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('CANCELAR'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
