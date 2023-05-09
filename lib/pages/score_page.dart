import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/menu_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:hotnewsquiz/components/normal_text.dart';

class ScorePage extends StatefulWidget {
  final int score;
  const ScorePage(this.score, {super.key});

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
                  top: 20.0, bottom: 3.0, left: 8.0, right: 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Text("結果",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 25)),
                  const SizedBox(height: 25),
                  Center(
                    child: CircularPercentIndicator(
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
                  const SizedBox(height: 25),
                  // const Divider(thickness: 1.5),
                  GestureDetector(
                    onTap: () {
                      // Delete the existing instance of QuizController
                      Get.delete<QuizController>();
                      // Create a new instance of QuizController and add it to the GetX dependency injection system
                      Get.put(QuizController());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuPage()),
                      );
                    },
                    child: NormalText("解答を確認する", color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                // Delete the existing instance of QuizController
                Get.delete<QuizController>();
                // Create a new instance of QuizController and add it to the GetX dependency injection system
                Get.put(QuizController());

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                  (route) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: NormalText(
                    "メニューに戻る",
                    color: Colors.purple,
                  ),
                ),
              ),
            )
            // GestureDetector(
            // onTap: () {
            //   // Delete the existing instance of QuizController
            //   Get.delete<QuizController>();
            //   // Create a new instance of QuizController and add it to the GetX dependency injection system
            //   Get.put(QuizController());

            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => const MenuPage()),
            //     (route) => false,
            //   );
            // },
            // child: Container(
            //   padding: EdgeInsets.all(8.0),
            //   margin: EdgeInsets.symmetric(horizontal: 20.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Center(
            //     child: NormalText(
            //       "メニューに戻る",
            //       color: Colors.purple,
            //     ),
            //   ),
            // ),
          ],
        )),
      ),
    );
  }
}
