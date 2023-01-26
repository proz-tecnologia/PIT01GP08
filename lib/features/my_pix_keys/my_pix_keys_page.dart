import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/pix_repository.dart';
import '../../shared/views/error_view.dart';
import '../../shared/views/loading_view.dart';
import 'my_pix_keys_controller.dart';
import 'my_pix_keys_states.dart';

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
            onPressed: () =>
                Navigator.of(context).pushNamed('/category-edit').then((_) {
              setState(() {});
            }),
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
              itemBuilder: (_, index) => ListTile(
                title: Text(list[index].key),
                trailing: Text(list[index].value),
              ),
            );
          }
          return const LoadingView();
        },
      ),
    );
  }
}
