import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double size;

  const NormalText(
    this.text,
    this.size, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
      ),
    );
  }
}
