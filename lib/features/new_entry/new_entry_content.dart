import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../../shared/widgets/top_bar_toggle_button.dart';
import 'widgets/currency_field.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/toggle_buttons.dart';
import 'new_entry_controller.dart';
import 'new_entry_states.dart';

class NewEntryContent extends StatefulWidget {
  const NewEntryContent({
    Key? key,
  }) : super(key: key);

  @override
  State<NewEntryContent> createState() => _NewEntryContentState();
}

class _NewEntryContentState extends State<NewEntryContent> {
  final formKey = GlobalKey<FormState>();
  final fulfilled = ValueNotifier(true);

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
                  onPressed: () => controller.changeType(false),
                ),
                TopBarToggleButton.income(
                  isSelected: state is IncomeNewEntryState,
                  onPressed: () => controller.changeType(true),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Sizes.largeSpace),
                child: Column(
                  children: <Widget>[
                    CurrencyFormField(color: state.color),
                    const SizedBox(height: Sizes.smallSpace),
                    TextFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: state.color),
                        labelStyle:
                            TextStyle(color: state.color.withOpacity(0.6)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: state.color)),
                        labelText: 'Descrição',
                      ),
                      cursorColor: AppColors.lightGrey,
                    ),
                    const SizedBox(height: Sizes.smallSpace),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(color: state.color),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: state.color)),
                        labelText: 'Categoria',
                      ),
                      value: categories[0],
                      items: categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: Sizes.mediumSpace),
                    AppToggleButtons(color: state.color),
                    const SizedBox(height: Sizes.smallSpace),
                    AppDatePickerField(color: state.color),
                    const SizedBox(height: Sizes.smallSpace),
                    ValueListenableBuilder(
                      valueListenable: fulfilled,
                      builder: (context, value, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Previsto'),
                            Switch(
                                activeTrackColor: state.color,
                                activeColor: AppColors.white,
                                value: value,
                                onChanged: (value) => fulfilled.value = value),
                            Text(state.initialFulfilledLabel),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(Sizes.mediumSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('OK'),
                    ),
                  ),
                  const SizedBox(height: Sizes.mediumSpace),
                  TextButton(
                    onPressed: () {},
                    child: const Text('CANCELAR'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
