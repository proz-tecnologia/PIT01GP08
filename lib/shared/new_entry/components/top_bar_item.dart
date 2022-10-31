import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class NewEntryTopBarItem extends StatelessWidget {
  const NewEntryTopBarItem(
    String text, {
    Key? key,
    required Color color,
    required bool selected,
    VoidCallback? onPressed,
  })  : _text = text,
        _color = color,
        _selected = selected,
        _onPressed = onPressed,
        super(key: key);

  final String _text;
  final Color _color;
  final bool _selected;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: _onPressed ?? () {},
            style: TextButton.styleFrom(
              foregroundColor: _selected ? _color : AppColors.darkGrey,
            ),
            child: Text(_text),
          ),
        ),
        _selected
            ? Container(
                color: _color,
                width: MediaQuery.of(context).size.width / 2,
                height: 2,
              )
            : Container(),
      ]),
    );
  }
}
