import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotnewsquiz/models/question.dart';
import 'package:hotnewsquiz/models/quiz.dart';

class QuizHelper {
  static Stream<List<Question>> questionStream() {
    return FirebaseFirestore.instance
        .collection('quiz')
        .orderBy('published_date', descending: true)
        .limit(40)
        .snapshots()
        .map((query) {
      List<Question> questions = [];
      for (var data in query.docs) {
        final question = Question.fromDocumentSnapshot(data);
        questions.add(question);
      }
      return questions;
    });
  }

  //Obtain the list of quizzes, which are actually the list of dates in document id
  static Stream<List<Quiz>> quizListStream() {
    return FirebaseFirestore.instance
        .collection('quiz')
        .orderBy('published_date', descending: true)
        .limit(40)
        .snapshots()
        .map((query) {
      //Use Set to exclude duplicated values
      Set<String> quizKeyList = Set<String>();
      List<Quiz> quizList = [];

      for (var data in query.docs) {
        String dateString = data.id.substring(9, 17);
        quizKeyList.add(dateString);
      }

      //after identifying all the unique quiz keys, convert it to List<Quiz>.
      for (var quizKey in quizKeyList) {
        DateTime date = DateTime.parse(quizKey);
        String japaneseDate = "${date.year}年${date.month}月${date.day}日"
            .replaceAll(RegExp(r'(?<!\d)0'), '');
        quizList.add(Quiz(quizText: japaneseDate, quizKey: quizKey));
      }

      return quizList;
    });
  }
}
