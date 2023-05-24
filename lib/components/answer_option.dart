import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class AnswerOption extends StatefulWidget {
  final String optionText;
  final int optionId;
  final String trueAnswer;
  final int selectedAnswer;

  const AnswerOption(this.optionText,
      {required this.trueAnswer,
      required this.optionId,
      required this.selectedAnswer});

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find<QuizController>();

    //Convert trueAnswer to integer
    int trueAnswerInt = convertToAnswerInt(widget.trueAnswer);

    final bool isCorrect = (widget.optionId == trueAnswerInt);
    final bool isSelected = (widget.optionId == widget.selectedAnswer);

    //Decide on the color of the pill
    Color answerColor = Colors.grey;
    if (isCorrect) {
      answerColor = Colors.green;
    } else if (isSelected) {
      answerColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: answerColor),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose, // Allow the text to wrap within available space
            child: Text(
              widget.optionText.trim(),
              style: TextStyle(
                color: answerColor,
                fontSize: 18,
              ),
              overflow: TextOverflow.clip, // Set overflow to clip
            ),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: answerColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: answerColor),
            ),
            child: Icon(
              (answerColor == Colors.green)
                  ? Icons.done
                  : (answerColor == Colors.red)
                      ? Icons.close
                      : null,
              size: 16,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  int convertToAnswerInt(String answerString) {
    if (answerString.trim() == "A") {
      return 0;
    } else if (answerString.trim() == "B") {
      return 1;
    } else if (answerString.trim() == "C") {
      return 2;
    } else if (answerString.trim() == "D") {
      return 3;
    } else {
      return 99;
    }
  }
}
