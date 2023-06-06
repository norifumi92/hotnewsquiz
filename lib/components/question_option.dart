import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';

class QuestionOption extends StatefulWidget {
  final String optionText;
  final int optionId;

  const QuestionOption(
      {required this.optionText, required this.optionId, Key? key})
      : super(key: key);

  @override
  _QuestionOptionState createState() => _QuestionOptionState();
}

class _QuestionOptionState extends State<QuestionOption> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find<QuizController>();
    return GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = true;
          });

          //save the answer selected to quizController's list
          quizController.selectedAnswerList.add(widget.optionId);

          //STEP1: Check if the question is the last one
          bool isLastQuestion = quizController.isLastQuestion();

          //if this is not the last question, go to the next question
          if (!isLastQuestion) {
            quizController.nextQuestion();
            quizController.rxRemainingTime.value = 30 + 1;
          }

          //If this is the last, show the loading dialog until the score is calculated or 2 seconds has passed.
          else {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });

            quizController.moveToScorePage();

            final quizPageState =
                context.findAncestorStateOfType<QuizPageState>();
            quizPageState?.resetTimer();
          }
        },
        child: Container(
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
        ));
  }
}
