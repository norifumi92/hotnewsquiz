import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';

class QuestionOption extends StatefulWidget {
  final String optionText;

  const QuestionOption(this.optionText);

  @override
  _QuestionOptionState createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.put<QuizController>(QuizController());
    return GestureDetector(
        onTap: () {
          // Go to the next page
          quizController.nextQuestion();

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
              widget.optionText.trim(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            )
          ]),
        ));
  }
}
