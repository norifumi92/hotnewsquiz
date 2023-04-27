import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/quiz_option.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    //load quizzes from question controller. initState is called only once.
    // _loadQuestions(); -- This does not work because initState cannot wait for the response

    //delay the start of the quiz as quiz widget takes time to display.
    Future.delayed(const Duration(seconds: 2), () {
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

  int seconds = 30;
  Timer? timer;
  bool _isSelected = false;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          _isSelected = true;
        }
      });
    });
  }

  // Define your kGradientPrimary gradient here
  final kGradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.pink.shade700,
      Colors.pink.shade200,
    ],
  );

  @override
  Widget build(BuildContext context) {
    // print("Number of Quiz: ${questions.length}");

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade300, Colors.purple.shade900],
          )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            width = constraints.maxWidth * seconds / 30;
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
                          children: [NormalText("残り${seconds}秒", 12)],
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                GetX<QuizController>(
                    init: Get.put<QuizController>(QuizController()),
                    builder: (QuizController quizController) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: quizController.questions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: NormalText("第一問", 20.0),
                                  ),
                                  Divider(thickness: 1.5),
                                  SizedBox(
                                    width: double.infinity,
                                    // height: 200,
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(quizController
                                              .questions[index].questionText)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  QuizOption(
                                      quizController
                                          .questions[index].options[0],
                                      _isSelected),
                                  QuizOption(
                                      quizController
                                          .questions[index].options[1],
                                      _isSelected),
                                  QuizOption(
                                      quizController
                                          .questions[index].options[2],
                                      _isSelected),
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
