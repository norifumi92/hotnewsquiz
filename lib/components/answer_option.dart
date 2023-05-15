import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class AnswerOption extends StatefulWidget {
  final String optionText;
  final int selectedAnswer;

  const AnswerOption(this.optionText, this.selectedAnswer);

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find<QuizController>();
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        color: _isSelected ? Colors.purple.shade700 : Colors.white,
      ),
      child: Row(
        children: [
          Flexible(
            child: Text(
              widget.optionText.trim(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              overflow: TextOverflow.clip, // Set overflow to clip
            ),
          ),
        ],
      ),
    );
  }
}
