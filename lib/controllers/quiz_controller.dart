import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/helpers/quiz_helper.dart';
import 'package:hotnewsquiz/models/quiz.dart';
import 'package:hotnewsquiz/pages/score_page.dart';

class QuizController extends GetxController {
  //Define questionList and its getter
  Rx<List<Question>> questionList = Rx<List<Question>>([]);
  List<Question> get questions => questionList.value;

  //Define pickedQuestionList and its getter
  Rx<List<Question>> pickedQuestionList = Rx<List<Question>>([]);
  List<Question> get pickedQuestions => pickedQuestionList.value;

  //Define quizList and its getter
  Rx<List<Quiz>> quizList = Rx<List<Quiz>>([]);
  List<Quiz> get quizzes => quizList.value;

  //Define score and its getter
  RxInt rxScore = RxInt(0);
  int get score => rxScore.value;

  //Store the list of user's answers
  var selectedAnswerList = [].obs;

  // Declare a PageController variable in your state or controller
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  @override
  void onReady() {
    try {
      questionList.bindStream(QuizHelper.questionStream());
      quizList.bindStream(QuizHelper.quizListStream());
    } catch (e) {
      // Exception handling code
      print('Data was not fetched from Firebase.');
      print('Exception caught: $e');
    }
  }

  //pick up questions to display
  void pickUpQuestions(quizKey) {
    //convert quizKey to match it with published date of Questions
    String formattedQuizKey =
        "${quizKey.substring(0, 4)}-${quizKey.substring(4, 6)}-${quizKey.substring(6, 8)}";

    print(formattedQuizKey);
    List<Question> pickedQuestions = questionList.value
        .where((question) => question.publishedDate == formattedQuizKey)
        .toList();

    //Update pickedQuestionList
    pickedQuestionList.value = pickedQuestions;
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
      int score = calculateScore();
      rxScore.value = score;
      // Page transition should happen using Navigator but Get.to so the controller will not be destroyed
      Get.to(ScorePage());
    });
  }

  //define method for score calculation
  int calculateScore() {
    int score = 0;
    for (int i = 0;
        i < selectedAnswerList.length && i < pickedQuestionList.value.length;
        i++) {
      int trueAnswer = convertToAnswerInt(pickedQuestionList.value[i].answer);
      if (selectedAnswerList[i] == trueAnswer) {
        print(selectedAnswerList[i]);
        print(trueAnswer);
        score++;
      }
    }
    return score;
  }

  //convert alphabetic answer to integer
  int convertToAnswerInt(String answerString) {
    if (answerString.trim() == "A") {
      return 0;
    } else if (answerString.trim() == "B") {
      return 1;
    } else if (answerString.trim() == "C") {
      return 2;
    } else if (answerString.trim() == "D") {
      return 3;
    } else {
      return 99;
    }
  }
}
