import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class QuestionOption extends StatefulWidget {
  final String optionText;
  final int selectedAnswer;

  const QuestionOption(this.optionText, this.selectedAnswer);

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
          quizController.selectedAnswerList.add(widget.selectedAnswer);

          int currentPageCount = quizController.pageController.page!.toInt();
          int currentQuestionNumber = currentPageCount + 1;

          //for now, hardcode the question count
          const int questionCount = 5;

          //if this is not the last question, go to the next question
          if (currentQuestionNumber < questionCount) {
            quizController.nextQuestion();
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

            //Instead of passing the resetTimer function from QuizPage up until here, get it from context
            final _quizPageState =
                context.findAncestorStateOfType<QuizPageState>();
            _quizPageState?.resetTimer();

            quizController.timeUp();

            // pop the loading circle
            // Navigator.pop(context);

            // move to score page
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       //builder: (context) => StartAnimationPage()),
            //       builder: (context) => const ScorePage()),
            // );
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
