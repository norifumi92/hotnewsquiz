import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/components/question_card.dart';
import 'package:hotnewsquiz/models/quiz.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;
  const QuizPage(this.quiz, {super.key});

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  final QuizController quizController = Get.put(QuizController());
  List<Question> questions = [];
  int seconds = 60;

  @override
  void initState() {
    super.initState();
    //load quizzes from question controller. initState is called only once.
    // _loadQuestions(); -- This does not work because initState cannot wait for the response

    //delay the start of the quiz as quiz widget takes time to display.
    Future.delayed(const Duration(seconds: 1), () {
      startTimer();
    });
  }

  // void _loadQuestions() async {
  //   final QuizController quizController = Get.put(QuizController());
  //   questions = await quizController.questions;
  //   print(questions);
  // }

  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  Timer? timer;
  bool _isSelected = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // print(seconds);
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          _isSelected = true;
          //Call timeup in QuizController
          quizController.timeUp();

          // move to score page
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       //builder: (context) => StartAnimationPage()),
          //       builder: (context) => const ScorePage()),
          // );
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      seconds = 60; // replace 30 with your initial value
      timer?.cancel(); // cancel the current timer if it exists
      _isSelected = false; // reset _isSelected flag if needed
    });
  }

  // Define your kGradientPrimary gradient here
  final kGradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.teal.shade700,
      Colors.teal.shade200,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade700, Colors.purple.shade900],
          )),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double width;
                          if (seconds > 3) {
                            width = constraints.maxWidth * seconds / 60;
                          } else if (seconds > 0) {
                            width = constraints.maxWidth * 0.1;
                          } else {
                            width = 0;
                          }

                          return Container(
                            width: width,
                            decoration: BoxDecoration(
                              gradient: kGradientPrimary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          );
                        },
                      ),
                      Positioned.fill(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [NormalText("残り${seconds}秒", size: 15)],
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                GetX<QuizController>(
                    init: Get.find<QuizController>(),
                    builder: (QuizController quizController) {
                      return Expanded(
                        child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: quizController.pageController,
                            itemCount: quizController.pickedQuestions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: NormalText(
                                        "${widget.quiz.quizText} 第${index + 1}問"),
                                  ),
                                  const Divider(thickness: 1.5),
                                  const SizedBox(height: 10),
                                  QuestionCard(
                                      question: quizController
                                          .pickedQuestions[index]),
                                ],
                              );
                            }),
                      );
                    }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
