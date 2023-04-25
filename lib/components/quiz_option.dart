import 'package:flutter/material.dart';

class QuizOption extends StatefulWidget {
  final String option_text;
  bool _isSelected;

  QuizOption(
    this.option_text,
    this._isSelected, {
    Key? key,
  }) : super(key: key);

  @override
  _QuizOptionState createState() => _QuizOptionState();
}

class _QuizOptionState extends State<QuizOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget._isSelected = true;
        });
        // Start loading here
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget._isSelected ? Colors.grey.shade500 : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Flexible(
              child: Text(
                widget.option_text,
                style: TextStyle(color: Colors.grey.shade900),
                maxLines: null,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
