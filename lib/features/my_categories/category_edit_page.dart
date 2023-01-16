import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import '../../services/category_repository.dart';
import '../../shared/models/category.dart';
import 'my_categories_controller.dart';
import 'my_categories_states.dart';
import 'widgets/category_toggle_button.dart';
import 'widgets/color_picker.dart';
import 'widgets/icon_picker.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({super.key});

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController(text: 'Nova categoria');
  final icon = ValueNotifier(Icons.attach_money_rounded);
  final color = ValueNotifier<Color>(Colors.blue);
  final type = ValueNotifier<Type>(Type.income);

  final controller = MyCategoriesController.instance(
    CategoryFirebaseRepository(
      FirebaseFirestore.instance,
      FirebaseAuth.instance,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category?;
    if (category != null) {
      name.text = category.name;
      icon.value = category.icon;
      color.value = category.color;
      type.value = category.type;
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Sizes.largeSpace),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: color,
                      builder: (_, value, __) => InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => ColorPicker(color),
                        ),
                        child: CircleAvatar(
                            radius: Sizes.largeIconSize,
                            backgroundColor: value),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: icon,
                      builder: (_, value, __) => InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => IconPicker(icon),
                        ),
                        child: Icon(
                          icon.value,
                          size: Sizes.largeIconSize,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.smallSpace),
                TextFormField(
                  controller: name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                  cursorColor: Theme.of(context).dividerColor,
                ),
                const SizedBox(height: Sizes.mediumSpace),
                CategoryToogleButton(type: type),
                const SizedBox(height: Sizes.mediumSpace),
                BlocConsumer<MyCategoriesController, MyCategoriesState>(
                  bloc: controller,
                  listener: (context, state) {
                    if (state is SaveErrorMyCategoriesState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is SavedMyCategoriesState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${name.text} salvo com sucesso!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return state is SavingMyCategoriesState
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.saveCategory(category?.id,
                                      color: color.value,
                                      name: name.text,
                                      type: type.value,
                                      icon: icon.value);
                                }
                              },
                              child: const Text('SALVAR'),
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
    );
  }
}
