import 'package:flutter/material.dart';
import 'package:hotnewsquiz/pages/menu_page.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/controllers/quiz_controller.dart';
import 'package:hotnewsquiz/components/normal_text.dart';

class GoBackToMenuButton extends StatelessWidget {
  const GoBackToMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
      child: Center(
        child: NormalText(
          "メニューに戻る",
        ),
      ),
    );
  }
}
