import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class AnswerOption extends StatefulWidget {
  final String optionText;
  final int optionIndex;
  final int trueAnswer;

  const AnswerOption(this.optionText,
      {required this.trueAnswer, required this.optionIndex});

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find<QuizController>();
    final bool isCorrect = (widget.optionIndex == widget.trueAnswer);

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: isCorrect ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.optionText.trim(),
            style: TextStyle(
              color: isCorrect ? Colors.green : Colors.grey,
              fontSize: 18,
            ),
            overflow: TextOverflow.clip, // Set overflow to clip
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: isCorrect ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: isCorrect ? Colors.green : Colors.grey),
            ),
            child: Icon(
              isCorrect ? Icons.close : null,
              size: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
