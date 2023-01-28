import 'package:flutter/material.dart';

import '../../design_sys/sizes.dart';
import '../../shared/widgets/animated_logo.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});
  final Image _logo = Image.asset('assets/logo_colors.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cashfy',
                style: TextStyle(fontSize: Sizes.largeSpace),
              ),
              const Text('Versão 0.9.20'),
              Padding(
                padding: const EdgeInsets.only(
                    top: Sizes.logoSize, bottom: Sizes.logoSize),
                child: SizedBox(
                  height: Sizes.logoSize,
                  child: AnimatedLogo(logo: _logo),
                ),
              ),
              const Divider(
                height: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const ListTile(
                  title: Text('Ajuda com o Cashfy'),
                ),
              ),
              const Divider(
                height: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const ListTile(
                  title: Text('Informar um problema'),
                ),
              ),
              const Divider(
                height: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const ListTile(
                  title: Text('Licenças'),
                ),
              ),
              const Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
