import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool selectable;

  const NormalText(
    this.text, {
    this.color = Colors.white,
    this.size = 18.0,
    this.selectable = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectable
        ? SelectableText(
            text,
            style: TextStyle(
              color: color,
              fontSize: size,
            ),
          )
        : Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: size,
            ),
          );
  }
}
