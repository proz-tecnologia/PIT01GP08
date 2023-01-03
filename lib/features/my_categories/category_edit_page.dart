import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import '../../design_sys/sizes.dart';
import '../../shared/models/category.dart';
import 'my_categories_controller.dart';
import 'my_categories_states.dart';
import 'widgets/color_picker.dart';
import 'widgets/icon_picker.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({super.key, this.category});

  final Category? category;

  @override
  State<CategoryEditPage> createState() => _NewEntryContentState();
}

class _NewEntryContentState extends State<CategoryEditPage> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final icon = ValueNotifier(Icons.monetization_on_rounded);
  final color = ValueNotifier<Color>(Colors.indigo);
  final type = ValueNotifier<Type>(Type.income);

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      name.text = widget.category!.name;
      icon.value = widget.category!.icon;
      color.value = widget.category!.color;
      type.value = widget.category!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: formKey,
          child: Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Sizes.largeSpace),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    cursorColor: Theme.of(context).dividerColor,
                  ),
                  const SizedBox(height: Sizes.smallSpace),
                  ValueListenableBuilder(
                    valueListenable: icon,
                    builder: (_, value, __) => InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => IconPicker(icon),
                      ),
                      child: Icon(icon.value),
                    ),
                  ),
                  const SizedBox(height: Sizes.smallSpace),
                  ValueListenableBuilder(
                    valueListenable: color,
                    builder: (_, value, __) => InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => ColorPicker(icon),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color.value,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Sizes.mediumSpace),
                  ValueListenableBuilder(
                    valueListenable: type,
                    builder: (_, value, __) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Despesas'),
                          Switch(
                              inactiveTrackColor: AppColors.expense,
                              activeTrackColor: AppColors.income,
                              activeColor: AppColors.white,
                              value: value == Type.income,
                              onChanged: (value) => type.value =
                                  value ? Type.income : Type.expense),
                          const Text('Receitas'),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: Sizes.mediumSpace),
                  BlocBuilder<MyCategoriesController, MyCategoriesState>(
                    builder: (context, state) {
                      final saveController =
                          context.read<MyCategoriesController>();
                      return state is SavingMyCategoriesState
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    saveController.saveCategory(
                                        widget.category?.id,
                                        color: color.value,
                                        name: name.text,
                                        type: type.value,
                                        icon: icon.value);
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
    );
  }
}
