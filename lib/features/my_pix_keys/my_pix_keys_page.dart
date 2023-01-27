import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/colors.dart';
import '../../services/pix_repository.dart';
import '../../shared/views/error_view.dart';
import '../../shared/views/loading_view.dart';
import 'my_pix_keys_controller.dart';
import 'my_pix_keys_states.dart';
import 'widgets/pix_key_form_dialog.dart';

class MyPixKeysPage extends StatefulWidget {
  const MyPixKeysPage({super.key});

  @override
  State<MyPixKeysPage> createState() => _MyPixKeysPageState();
}

class _MyPixKeysPageState extends State<MyPixKeysPage> {
  @override
  Widget build(BuildContext context) {
    final controller = MyPixKeysController.instance(
      PixFirebaseRepository(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Categorias"),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                final formKey = GlobalKey<FormState>();
                return PixKeyFormDialog(
                  formKey: formKey,
                  controller: controller,
                );
              },
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<MyPixKeysController, MyPixKeysState>(
        bloc: controller,
        builder: (context, state) {
          if (state is ErrorMyPixKeysState) {
            return ErrorView(
              icon: Icons.cloud_off_rounded,
              text: state.message,
            );
          }
          if (state is SuccessMyPixKeysState) {
            final list = List.from(state.list.entries);
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (_, index) => ExpansionTile(
                title: Text(list[index].key),
                trailing: Text(list[index].value),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: AppColors.expense,
                        ),
                      ),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            final formKey = GlobalKey<FormState>();
                            final description = list[index].key;
                            final pixKey = list[index].value;
                            return PixKeyFormDialog(
                              formKey: formKey,
                              initialDescription: description,
                              initialPixKey: pixKey,
                              controller: controller,
                            );
                          },
                        ),
                        icon: const Icon(Icons.edit_rounded),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.copy_rounded),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return const LoadingView();
        },
      ),
    );
  }
}
