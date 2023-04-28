import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/helpers/question_helper.dart';

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
    _pageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
