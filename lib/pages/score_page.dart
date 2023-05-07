import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/home_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Text("あなたのスコア",
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 25)),
                const SizedBox(height: 25),
                Center(
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: 100,
                    lineWidth: 30,
                    percent: 0.4,
                    progressColor: Colors.teal,
                    backgroundColor: Colors.teal.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text("2/5",
                        style: TextStyle(
                            fontSize: 50, color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    // Delete the existing instance of QuizController
                    Get.delete<QuizController>();
                    // Create a new instance of QuizController and add it to the GetX dependency injection system
                    Get.put(QuizController());

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Text("メニューに戻る",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
