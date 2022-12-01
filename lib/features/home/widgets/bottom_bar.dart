import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required Function(int index) navigate,
  })  : _navigate = navigate,
        super(key: key);

  final Function(int index) _navigate;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          label: 'Extrato',
        ),
        BottomNavigationBarItem(
            icon: Container(),
            label: ''), // item vazio com o único objetivo de melhorar o layout
        const BottomNavigationBarItem(
          icon: Icon(Icons.equalizer_rounded),
          label: 'Estatística',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'Mais',
        ),
      ],
      currentIndex: index,
      onTap: (index) {
        widget._navigate;
        this.index = index;
      },
    );
  }
}
