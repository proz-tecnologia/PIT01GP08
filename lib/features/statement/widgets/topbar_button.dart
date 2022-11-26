import 'package:flutter/material.dart';

import '../../../design_sys/colors.dart';

class NewEntryTopBarItem extends StatefulWidget {
  const NewEntryTopBarItem(
    String text, {
    Key? key,
    required Color color,
  })  : _text = text,
        _color = color,
        super(key: key);

  final String _text;
  final Color _color;

  @override
  State<NewEntryTopBarItem> createState() => _NewEntryTopBarItemState();
}

class _NewEntryTopBarItemState extends State<NewEntryTopBarItem> {
  final bool _selected = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: _selected ? widget._color : AppColors.darkGrey,
            ),
            child: Text(widget._text),
          ),
        ),
        _selected
            ? Container(
                color: widget._color,
                width: MediaQuery.of(context).size.width / 2,
                height: 2,
              )
            : Container(),
      ]),
    );
  }
}
