import 'package:flutter/material.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/components/answer_card.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/components/normal_text.dart';
import 'package:hotnewsquiz/components/go_back_to_menu.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.purple.shade300, Colors.purple.shade900],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Center(
                    child: NormalText(
                  '解答',
                  size: 25,
                )),
                Divider(height: 10),
                GetX<QuizController>(
                  init: Get.find<QuizController>(),
                  builder: (QuizController quizController) {
                    return Column(
                      children: quizController.pickedQuestions.map((question) {
                        return AnswerCard(question: question);
                      }).toList(),
                    );
                  },
                ),
                const GoBackToMenuButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
