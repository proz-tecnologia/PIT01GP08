import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../design_sys/sizes.dart';
import '../../shared/models/category.dart';
import '../../shared/models/transaction.dart';
import '../page_view/widgets/top_bar_toggle_button.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';
import 'widgets/parts_form_field.dart';
import 'widgets/widgets.dart';

class NewEntryContent extends StatefulWidget {
  const NewEntryContent(this.categoryList, {super.key});

  final List<Category> categoryList;

  @override
  State<NewEntryContent> createState() => _NewEntryContentState();
}

class _NewEntryContentState extends State<NewEntryContent> {
  final formKey = GlobalKey<FormState>();
  final fulfilled = ValueNotifier(true);
  final paymentOption = ValueNotifier(0);

  final value = TextEditingController();
  final totalValueNotifier = ValueNotifier(0.0);
  final description = TextEditingController();
  final category = ValueNotifier<Category?>(null);
  final date = TextEditingController();
  final endDate = TextEditingController();
  final parts = TextEditingController(text: '2');

  late final NewEntryTypeController controller;

  @override
  void initState() {
    super.initState();
    controller = NewEntryTypeController(widget.categoryList);
  }

  @override
  Widget build(BuildContext context) {
    final transaction =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as Transaction?;
    if (transaction != null) {
      fulfilled.value = transaction.fulfilled;
      paymentOption.value = Payment.values.indexOf(transaction.payment);
      category.value =
          widget.categoryList.firstWhere((e) => e.id == transaction.categoryId);
      totalValueNotifier.value = transaction.value;
      value.text = transaction.valueString;
      description.text = transaction.description;
      date.text = DateFormat('dd/MM/yyyy').format(transaction.date);
      if (transaction.endDate != null) {
        endDate.text = DateFormat('dd/MM/yyyy').format(transaction.endDate!);
      }
      if (transaction.parts != null) {
        parts.text = transaction.parts.toString();
      }
      if (transaction.type == Type.income) {
        controller.changeType(isIncome: true);
      }
    }

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
                    CurrencyFormField(
                      value,
                      totalValueNotifier: totalValueNotifier,
                    ),
                    const SizedBox(height: Sizes.smallSpace),
                    DescriptionFormField(description),
                    const SizedBox(height: Sizes.smallSpace),
                    CategoryFormField(category),
                    const SizedBox(height: Sizes.mediumSpace),
                    PaymentFormField(paymentOption),
                    const SizedBox(height: Sizes.smallSpace),
                    DatePickerFormField(
                      date,
                      label: 'Vencimento',
                    ),
                    const SizedBox(height: Sizes.smallSpace),
                    ValueListenableBuilder(
                        valueListenable: paymentOption,
                        builder: (_, option, __) {
                          if (Payment.values[option] == Payment.fixa) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Sizes.smallSpace),
                              child: DatePickerFormField(
                                endDate,
                                label: 'Repetir até',
                              ),
                            );
                          }
                          if (Payment.values[option] == Payment.parcelada) {
                            return PartsFormField(
                              parts,
                              totalValueNotifier: totalValueNotifier,
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                    FulfilledFormField(fulfilled),
                    const SizedBox(height: Sizes.mediumSpace),
                    BlocBuilder<NewEntryController, NewEntryState>(
                      builder: (context, state) {
                        final saveController =
                            context.read<NewEntryController>();
                        return state is! InitialNewEntryState
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      saveController.saveTransaction(
                                        dateString: date.text,
                                        description: description.text,
                                        value: value.text,
                                        category: category.value,
                                        fulfilled: fulfilled.value,
                                        paymentOption: paymentOption.value,
                                        endDateString: endDate.text,
                                        partsString: parts.text,
                                      );
                                    }
                                  },
                                  child: const Text('OK'),
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: Sizes.mediumSpace),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCELAR'),
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
