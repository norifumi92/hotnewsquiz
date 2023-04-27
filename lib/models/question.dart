import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String questionText;
  List<String> options;
  String answer;

  Question({
    required this.questionText,
    required this.options,
    required this.answer,
  });

  factory Question.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Question(
      questionText: data['question'],
      options: List<String>.from(data['options']),
      answer: data['answer'],
    );
  }
}
