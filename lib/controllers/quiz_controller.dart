import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/helpers/question_helper.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class QuizController extends GetxController {
  Rx<List<Question>> questionList = Rx<List<Question>>([]);
  List<Question> get questions => questionList.value;

  // Declare a PageController variable in your state or controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  @override
  void onReady() {
    questionList.bindStream(QuestionHelper.questionStream());
  }

  //next question method using PageController
  void nextQuestion() {
    // The following logic was moved to quiz_option.dart
    // int currentPageCount = _pageController.page!.toInt();
    // int currentQuestionNumber = currentPageCount + 1;
    // int questionCount = questionList.value.length;
    // print("current page: ${currentPageCount}");
    // print("question count: ${questionCount}");
    // if (currentQuestionNumber < questionCount) {
    //   _pageController.nextPage(
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.easeInOut,
    //   );
    // } else {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     Get.to(ScorePage());
    //   });
    // }
    _pageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  //define method for timeup event
  void timeUp() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(ScorePage());
    });
  }
}
