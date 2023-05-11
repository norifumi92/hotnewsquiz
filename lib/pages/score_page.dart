import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/answer_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/go_back_to_menu.dart';

class ScorePage extends StatefulWidget {
  final int score;
  const ScorePage({this.score = 0, super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Align(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 3.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
              height: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text("テスト結果",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 25)),
                  const SizedBox(height: 15),
                  Center(
                    child: CircularPercentIndicator(
                      animationDuration: 1000,
                      animation: true,
                      radius: 100,
                      lineWidth: 30,
                      percent: widget.score / 5,
                      progressColor: Colors.teal,
                      backgroundColor: Colors.teal.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text("${widget.score}/5",
                          style: TextStyle(
                              fontSize: 50, color: Colors.grey.shade700)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      // Delete the existing instance of QuizController
                      // Get.delete<QuizController>();
                      // Create a new instance of QuizController and add it to the GetX dependency injection system
                      // Get.put(QuizController());

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnswerPage()),
                      );
                    },
                    child: NormalText("解答を確認する", color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const GoBackToMenuButton(),
          ],
        )),
      ),
    );
  }
}
