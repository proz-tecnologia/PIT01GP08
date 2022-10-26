import 'package:flutter/material.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          label: 'Extrato',
        ),
        BottomNavigationBarItem(
            icon: SizedBox(width: 1),
            label: ''), // item vazio com o único objetivo de melhorar o layout
        BottomNavigationBarItem(
          icon: Icon(Icons.equalizer_rounded),
          label: 'Estatística',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'Mais',
        ),
      ],
      currentIndex: index,
      onTap: ((index) {
        setState(() {
          widget._pageController.jumpToPage(index < 2 ? index : index - 1);
          this.index = index;
        });
      }),
    );
  }
}
