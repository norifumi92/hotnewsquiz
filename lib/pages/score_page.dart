import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/go_back_to_menu.dart';
import 'ad_test_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hotnewsquiz/pages/answer_page.dart';

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
                  ElevatedButton(
                    onPressed: () {
                      //Show a dialog to notice the user about the rewarded ad in advance
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('動画広告のお知らせ'),
                            content: Text(
                                'このアプリでは動画広告を再生した方のみに解答・解説を提供しています。同意いただける方のみ、「OK」を押して解答へお進みください。'),
                            actions: [
                              ElevatedButton(
                                child: Text('OK'),
                                onPressed: () {
                                  // For mobile, play the ad
                                  if (!kIsWeb) {
                                    Navigator.of(context).pop();
                                  }
                                  // For browser, skip the ad
                                  else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                AnswerPage())));
                                  }
                                },
                              ),
                              ElevatedButton(
                                child: Text('戻る'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                      //   //Only when the device is mobile, show the ad
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: ((context) => AdTestPage())));
                    },
                    child: const NormalText("解答をチェック"),
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
