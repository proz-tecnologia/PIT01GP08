import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(),
            accountName: Text('accountName'),
            accountEmail: Text('account@email.com'),
          ),
          DrawerTile(
            title: 'Minhas contas bancárias',
            icon: Icons.account_balance_rounded,
          ),
          DrawerTile(
            title: 'Meus cartões',
            icon: Icons.credit_card_rounded,
          ),
          DrawerTile(
            title: 'Categorias',
            icon: Icons.sell_rounded,
          ),
          Divider(),
          DrawerTile(
            title: 'Personalizar',
            icon: Icons.auto_awesome_rounded,
          ),
          DrawerTile(
            title: 'Conta',
            icon: Icons.account_circle,
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const DrawerTile({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: nav bank accounts
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
