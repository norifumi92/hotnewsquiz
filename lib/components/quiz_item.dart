import 'package:flutter/material.dart';
import 'package:hotnewsquiz/models/quiz.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:lottie/lottie.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/pages/quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizItem extends StatefulWidget {
  final Quiz quiz;
  final bool isCompleted;
  final int index;
  final double screenWidth;
  final bool startAnimation;

  const QuizItem(
    this.index, {
    required this.quiz,
    required this.isCompleted,
    required this.screenWidth,
    required this.startAnimation,
    super.key,
  });

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: widget.screenWidth * 0.8,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (widget.index * 200)),
      transform: Matrix4.translationValues(
          widget.startAnimation ? 0 : widget.screenWidth, 0, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          // color: _isButtonClicked ? Colors.grey.shade300 : Colors.white,
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Lottie.asset(
                          'assets/quiz_animation.json', // replace with your own file name
                          width: 300,
                          height: 300,
                        ),
                      );
                    });

                //updated picked question list in quizcontroller
                QuizController quizController = Get.find<QuizController>();
                quizController.pickUpQuestions(widget.quiz.quizKey);

                //Because the quiz is tapped, consider the quiz was already completed
                SharedPreferences prefs = await SharedPreferences.getInstance();
                // Step 1: Retrieve the existing list from SharedPreferences
                List<String> completedQuizzes =
                    prefs.getStringList('completedQuizzes') ?? [];

                // Step 2: Add the new element to the list
                completedQuizzes.add(widget.quiz.quizKey);

                // Step 3: Save the updated string back to SharedPreferences
                prefs.setStringList(
                    'completedQuizzes', completedQuizzes.toList());

                // Delay execution for 1.5 second before navigating to QuizPage
                Future.delayed(Duration(milliseconds: 1200), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPage(widget.quiz)),
                  );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isCompleted
                      ? Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Icon(
                            Icons.done,
                            size: 16,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Icon(
                            Icons.question_mark,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                  const SizedBox(width: 10),
                  NormalText(
                    "クイズ: ${widget.quiz.quizText}のニュースから",
                    size: 20,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
