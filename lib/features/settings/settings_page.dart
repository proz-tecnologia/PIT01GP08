//import 'package:financial_app/features/settings/settings_controller.dart';
import 'package:flutter/material.dart';

import 'widgets/select_conf_bio.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text("Segurança"),
          ),
          SelecConfBio(titleSelected: 'Ativar biometria/PIN'),
          //SelecConfBio(titleSelected: 'Login com email'),
        ],
      ),
    );
  }
}
