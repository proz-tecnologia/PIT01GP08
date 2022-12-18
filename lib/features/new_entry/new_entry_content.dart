import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import '../../shared/models/category.dart' as cModel;
import '../../shared/models/transaction.dart';
import '../../shared/widgets/top_bar_toggle_button.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';
import 'widgets/widgets.dart';

class NewEntryContent extends StatefulWidget {
  const NewEntryContent(this.categoryList, {super.key});

  final List<cModel.Category> categoryList;

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
    final controller = NewEntryTypeController(widget.categoryList);
    return BlocProvider(
      create: (context) => controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<NewEntryTypeController, NewEntryTypeState>(
            bloc: controller,
            builder: (context, state) {
              return Row(
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
              );
            },
          ),
          Form(
            key: formKey,
            child: Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Sizes.largeSpace),
                child: Column(
                  children: <Widget>[
                    CurrencyFormField(value),
                    const SizedBox(height: Sizes.smallSpace),
                    DescriptionFormField(description),
                    const SizedBox(height: Sizes.smallSpace),
                    CategoryFormField(category),
                    const SizedBox(height: Sizes.mediumSpace),
                    PaymentFormField(paymentOption),
                    const SizedBox(height: Sizes.smallSpace),
                    DatePickerFormField(date),
                    const SizedBox(height: Sizes.smallSpace),
                    FulfilledFormField(fulfilled),
                    const SizedBox(height: Sizes.mediumSpace),
                    Padding(
                      padding: const EdgeInsets.all(Sizes.mediumSpace),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child:
                                BlocBuilder<NewEntryController, NewEntryState>(
                              builder: (context, state) {
                                final controller =
                                    context.read<NewEntryController>();
                                return ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      controller.saveTransaction(
                                        Transaction(
                                          date: DateTime(
                                            int.parse(date.text.substring(6)),
                                            int.parse(
                                                date.text.substring(3, 5)),
                                            int.parse(
                                                date.text.substring(0, 2)),
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
                                );
                              },
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
      ),
    );
  }
}
