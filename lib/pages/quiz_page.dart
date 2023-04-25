import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hotnewsquiz/components/normal_text.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  int seconds = 30;
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
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
                        builder: (context, constraints) => Container(
                          width: seconds > 3
                              ? constraints.maxWidth * seconds / 30
                              : constraints.maxWidth * 0.1,
                          decoration: BoxDecoration(
                            gradient: kGradientPrimary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: NormalText("第一問", 10.0),
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
                        Text(
                            "日本銀行の植田和男新総裁が初めて臨む今週の金融政策決定会合では、どのような政策が継続されると見込まれているか。"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "A. 長期国債の購入による金融緩和政策",
                          style: TextStyle(color: Colors.grey.shade900),
                        )
                      ],
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
