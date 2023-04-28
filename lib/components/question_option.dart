import 'package:flutter/material.dart';

class QuestionOption extends StatefulWidget {
  final String option_text;
  final PageController pageController;

  QuestionOption(
    this.option_text,
    this.pageController, {
    Key? key,
  }) : super(key: key);

  @override
  _QuestionOptionState createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Go to the next page
          widget.pageController.nextPage(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
          setState(() {
            // widget._isSelected = true;
          });
          // Start loading here
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(children: [
            Text(
              widget.option_text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            )
          ]),
        ));
  }
}
