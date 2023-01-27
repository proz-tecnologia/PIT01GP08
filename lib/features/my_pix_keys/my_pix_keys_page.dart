import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: const Text("Minhas Chaves PIX"),
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
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'Tem certeza que deseja excluir ${list[index].key}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('CANCELAR'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.deleteKey(list[index].key);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('EXCLUIR'),
                              )
                            ],
                          ),
                        ),
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
                        onPressed: () async {
                          final scaffoldMessenger =
                              ScaffoldMessenger.of(context);
                          await Clipboard.setData(
                            ClipboardData(text: list[index].value),
                          );
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('Copiado: ${list[index].value}'),
                            ),
                          );
                        },
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
