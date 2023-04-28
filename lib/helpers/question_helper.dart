import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotnewsquiz/models/question.dart';

class QuestionHelper {
  static Stream<List<Question>> questionStream() {
    return FirebaseFirestore.instance
        .collection('quizzes')
        //Remove the following limit later.
        .limit(5)
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
}
