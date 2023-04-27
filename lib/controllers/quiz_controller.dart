import 'package:get/get.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/helpers/question_helper.dart';

class QuizController extends GetxController {
  Rx<List<Question>> questionList = Rx<List<Question>>([]);
  List<Question> get questions => questionList.value;

  @override
  void onReady() {
    questionList.bindStream(QuestionHelper.questionStream());
  }
}
